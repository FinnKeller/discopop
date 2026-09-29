# -*- coding: utf-8 -*-
"""Generator for 500 additional volatility benchmark cases (case_101 .. case_600).

Design rules, all of them derived from measurements rather than guessed:

_no cases
    Built only from structural families that a 35 probe pilot run proved to be
    STABLE for every WRITE_SAMPLE_BATCH in {64,128,256,512,1024,2048} at
    REPEAT_COUNT=100.  The pilot also identified four families that are NOT
    usable for split 1 because the sampling harness reports them volatile on
    its own:
        * static or global arrays whose cells are written
        * virtual dispatch (volatile at batch 64 and 128 even with a single
          implementation)
        * bulk write loops over stack arrays
        * elementwise write+read loops over stack arrays
    None of these appear in any generated _no case.

_yes cases
    Built by placing a rare-gate mechanism on top of one of those provably
    stable substrates, so the measured volatility is attributable to the
    injected mechanism and not to a harness artifact.  Rarity comes from a
    static tick counter that survives the repeat wrapper:
        if (tick % P == R) ...
    with P in the twenties and thirties, i.e. two to four hits per hundred
    repetitions.  Uniform rand() % N is never used as the volatility
    mechanism - every _yes failure of the previous run used it, because over
    100 repetitions each variant is observed many times and the union of
    dependencies survives sampling.  Virtual dispatch is likewise avoided,
    because it is volatile on its own and would make a case pass for the
    wrong reason.

    Side targeting:
        sinkvol - several write instructions, exactly one read instruction
        srcvol  - several read instructions, exactly one write instruction;
                  padding is placed *before* the write so that no shadow
                  memory clear can fall between write and read
        bothvol - rare gates on both ends, with coprime periods
"""

import hashlib
import os
import re
import shutil
import sys
import textwrap

TARGET = sys.argv[1]
EXISTING_DIRS = sys.argv[2:]

# ======================================================================
# helpers
# ======================================================================

def wrap_comment(text, prefix="//   "):
    out = []
    for para in text.strip().split("\n"):
        if not para.strip():
            out.append("//")
            continue
        out.extend(prefix + l for l in textwrap.wrap(para.strip(), 66))
    return "\n".join(out)


def structural_key(src):
    """Identity of a case modulo comments, whitespace and identifier suffixes."""
    s = re.sub(r"//[^\n]*", "", src)
    s = re.sub(r"\s+", " ", s)
    return hashlib.sha1(s.encode()).hexdigest()


class Case(object):
    def __init__(self):
        self.includes = []
        self.helpers = []
        self.body = []
        self.cleanup = []

    def inc(self, h):
        if h not in self.includes:
            self.includes.append(h)

    def helper(self, block):
        if block not in self.helpers:
            self.helpers.append(block)

    def render(self, name, number, split, source_doc, sink_doc, idea, expected):
        split_name = {
            1: "no volatility",
            2: "sink volatile only",
            3: "source volatile only",
            4: "source and sink volatile",
        }[split]
        head = []
        for h in self.includes:
            head.append("#include <%s>" % h)
        if head:
            head.append("")
        head.append("// " + "=" * 58)
        head.append("// Case %03d - Volatility split %d: %s" % (number, split, split_name))
        head.append("//   Source (read) : %s" % source_doc)
        head.append("//   Sink   (write): %s" % sink_doc)
        head.append("// Idea:")
        head.append(wrap_comment(idea))
        head.append("// Expected result:")
        head.append(wrap_comment(expected))
        head.append("// " + "=" * 58)
        head.append("")
        for block in self.helpers:
            head.append(block)
            head.append("")
        head.append("int main() {")
        for line in self.body:
            head.append("    " + line if line else "")
        for line in self.cleanup:
            head.append("    " + line if line else "")
        head.append("}")
        return "\n".join(head) + "\n"


# ======================================================================
# storages - every one of these was measured STABLE in the pilot
# ======================================================================

class Storage(object):
    def __init__(self, key, tier, build, note):
        self.key = key
        self.tier = tier
        self.build = build      # fn(case, T) -> (ref, addr)
        self.note = note


def _s_local_scalar(c, T):
    c.body.append("%s cell = 0;" % T)
    return "cell", "&cell"


def _s_static_scalar(c, T):
    c.body.append("static %s cell;" % T)
    c.body.append("cell = 0;")
    return "cell", "&cell"


def _s_global_scalar(c, T):
    c.helper("static %s g_cell;" % T)
    c.body.append("g_cell = 0;")
    return "g_cell", "&g_cell"


def _s_local_array(c, T):
    c.body.append("%s arr[16];" % T)
    return "arr[7]", "&arr[7]"


def _s_ptr_arith(c, T):
    c.body.append("%s arr[16];" % T)
    c.body.append("%s* cursor = arr + 5;" % T)
    return "*cursor", "cursor"


def _s_heap_cell(c, T):
    c.body.append("%s* cell = new %s(0);" % (T, T))
    c.cleanup.append("delete cell;")
    return "*cell", "cell"


def _s_heap_cell_leaked(c, T):
    c.body.append("%s* cell = new %s(0);" % (T, T))
    return "*cell", "cell"


def _s_malloc_cell(c, T):
    c.inc("stdlib.h")
    c.body.append("%s* cell = (%s*) malloc(sizeof(%s));" % (T, T, T))
    c.body.append("*cell = 0;")
    c.cleanup.append("free(cell);")
    return "*cell", "cell"


def _s_struct_field(c, T):
    c.helper("struct Box { %s guard; %s payload; };" % (T, T))
    c.body.append("Box box;")
    c.body.append("box.guard = 0;")
    return "box.payload", "&box.payload"


def _s_heap_struct(c, T):
    c.helper("struct Box { %s guard; %s payload; };" % (T, T))
    # deliberately not released, matching the probed shape
    c.body.append("Box* box = new Box;")
    c.body.append("box->guard = 0;")
    return "box->payload", "&box->payload"


def _s_nested_struct(c, T):
    c.helper("struct Inner { %s payload; };" % T)
    c.helper("struct Outer { %s guard; Inner inner; };" % T)
    c.body.append("Outer outer;")
    c.body.append("outer.guard = 0;")
    return "outer.inner.payload", "&outer.inner.payload"


def _s_heap_array(c, T):
    # deliberately not released: the pilot measured this exact shape - a heap
    # block whose address moves every repetition - as stable, while recycled
    # bulk written blocks were not probed.
    c.body.append("%s* buf = new %s[32];" % (T, T))
    c.body.append("for (int i = 0; i < 32; ++i) { buf[i] = 0; }")
    return "buf[13]", "&buf[13]"


def _s_rand_index(c, T):
    c.inc("stdlib.h")
    c.body.append("%s arr[16];" % T)
    c.body.append("int idx = rand() % 16;")
    return "arr[idx]", "&arr[idx]"


def _s_union_field(c, T):
    c.helper("union Slot { %s as_value; unsigned char raw[sizeof(%s)]; };" % (T, T))
    c.body.append("Slot slot;")
    return "slot.as_value", "&slot.as_value"


def _s_list_node(c, T):
    c.helper("struct Node { %s payload; Node* next; };" % T)
    c.body.append("Node head;")
    c.body.append("Node tail;")
    c.body.append("head.next = &tail;")
    c.body.append("tail.next = 0;")
    c.body.append("head.payload = 0;")
    return "tail.payload", "&tail.payload"


STORAGES = [
    Storage("local_scalar", 1, _s_local_scalar, "a plain stack scalar"),
    Storage("static_scalar", 1, _s_static_scalar, "a function local static scalar"),
    Storage("global_scalar", 1, _s_global_scalar, "a translation unit global scalar"),
    Storage("local_array", 2, _s_local_array, "one element of a stack array"),
    Storage("ptr_arith", 2, _s_ptr_arith, "a stack array element reached by pointer arithmetic"),
    Storage("heap_cell", 4, _s_heap_cell, "a heap cell allocated and released per repetition"),
    Storage("heap_cell_leaked", 4, _s_heap_cell_leaked, "a heap cell whose address moves every repetition"),
    Storage("malloc_cell", 4, _s_malloc_cell, "a malloc'ed cell released per repetition"),
    Storage("heap_struct", 4, _s_heap_struct, "a field of a heap struct"),
    Storage("rand_index", 2, _s_rand_index, "a stack array element whose index is drawn once and shared by both ends"),
    Storage("union_field", 5, _s_union_field, "the value member of a stack union"),
]

# ======================================================================
# write paths (the sink end) - single write instruction variants
# ======================================================================

class Path(object):
    def __init__(self, key, tier, build, note, needs_addr=False):
        self.key = key
        self.tier = tier
        self.build = build
        self.note = note
        self.needs_addr = needs_addr


def _w_direct(c, T, ref, addr, val, tag):
    c.body.append("%s = %s;%s" % (ref, val, tag))


def _w_local_ptr(c, T, ref, addr, val, tag):
    c.body.append("%s* sink_ptr = %s;" % (T, addr))
    c.body.append("*sink_ptr = %s;%s" % (val, tag))


def _w_ptr_chain(c, T, ref, addr, val, tag):
    c.body.append("%s* hop_a = %s;" % (T, addr))
    c.body.append("%s* hop_b = hop_a;" % T)
    c.body.append("%s* hop_c = hop_b;" % T)
    c.body.append("*hop_c = %s;%s" % (val, tag))


def _w_function(c, T, ref, addr, val, tag):
    c.helper("static void store_value(%s* target) {\n"
             "    *target = %s;%s\n}" % (T, val, tag))
    c.body.append("store_value(%s);" % addr)


def _w_reference(c, T, ref, addr, val, tag):
    c.helper("static void store_ref(%s& target) {\n"
             "    target = %s;%s\n}" % (T, val, tag))
    c.body.append("store_ref(%s);" % ref)


def _w_func_ptr(c, T, ref, addr, val, tag):
    c.helper("static void store_value(%s* target) {\n"
             "    *target = %s;%s\n}" % (T, val, tag))
    c.body.append("void (*sink_fp)(%s*) = store_value;" % T)
    c.body.append("sink_fp(%s);" % addr)


def _w_func_ptr_table(c, T, ref, addr, val, tag):
    c.inc("stdlib.h")
    c.helper("static void store_value(%s* target) {\n"
             "    *target = %s;%s\n}" % (T, val, tag))
    c.body.append("void (*sink_table[4])(%s*) = "
                  "{ store_value, store_value, store_value, store_value };" % T)
    c.body.append("sink_table[rand() %% 4](%s);" % addr)


def _w_lambda(c, T, ref, addr, val, tag):
    c.body.append("auto sink_lambda = [](%s* target) { *target = %s; };%s"
                  % (T, val, tag))
    c.body.append("sink_lambda(%s);" % addr)


def _w_two_level(c, T, ref, addr, val, tag):
    c.helper("static void store_inner(%s* target) {\n"
             "    *target = %s;%s\n}" % (T, val, tag))
    c.helper("static void store_outer(%s* target) {\n"
             "    store_inner(target);\n}" % T)
    c.body.append("store_outer(%s);" % addr)


def _w_template(c, T, ref, addr, val, tag):
    c.helper("template <typename V>\n"
             "static void store_generic(V* target, V value) {\n"
             "    *target = value;%s\n}" % tag)
    c.body.append("store_generic<%s>(%s, %s);" % (T, addr, val))


def _w_alias_choice(c, T, ref, addr, val, tag):
    c.inc("stdlib.h")
    c.body.append("%s* alias_a = %s;" % (T, addr))
    c.body.append("%s* alias_b = %s;" % (T, addr))
    c.body.append("%s* chosen = (rand() %% 2 == 0) ? alias_a : alias_b;" % T)
    c.body.append("*chosen = %s;%s" % (val, tag))


WRITE_PATHS = [
    Path("direct", 1, _w_direct, "a plain assignment"),
    Path("local_ptr", 1, _w_local_ptr, "an assignment through a local pointer"),
    Path("ptr_chain", 2, _w_ptr_chain, "an assignment through a three hop pointer chain"),
    Path("function", 3, _w_function, "an assignment inside a writer function"),
    Path("reference", 3, _w_reference, "an assignment through a reference parameter"),
    Path("func_ptr", 3, _w_func_ptr, "an assignment reached through a function pointer with a single target"),
    Path("func_ptr_table", 3, _w_func_ptr_table, "an assignment reached through a randomly indexed table whose slots are all the same function"),
    Path("lambda", 3, _w_lambda, "an assignment inside a lambda"),
    Path("two_level", 3, _w_two_level, "an assignment two call levels down"),
    Path("template", 5, _w_template, "an assignment inside a function template instance"),
    Path("alias_choice", 5, _w_alias_choice, "an assignment through one of two pointers that denote the same object"),
]


# ======================================================================
# read paths (the source end) - single read instruction variants
# ======================================================================

def _r_direct(c, T, ref, addr, tag):
    c.body.append("%s observed = %s;%s" % (T, ref, tag))
    return "observed"


def _r_local_ptr(c, T, ref, addr, tag):
    c.body.append("const %s* src_ptr = %s;" % (T, addr))
    c.body.append("%s observed = *src_ptr;%s" % (T, tag))
    return "observed"


def _r_function(c, T, ref, addr, tag):
    c.helper("static %s load_value(const %s* source) {\n"
             "    return *source;%s\n}" % (T, T, tag))
    c.body.append("%s observed = load_value(%s);" % (T, addr))
    return "observed"


def _r_reference(c, T, ref, addr, tag):
    c.helper("static %s load_ref(const %s& source) {\n"
             "    return source;%s\n}" % (T, T, tag))
    c.body.append("%s observed = load_ref(%s);" % (T, ref))
    return "observed"


def _r_lambda(c, T, ref, addr, tag):
    c.body.append("auto src_lambda = [](const %s* source) { return *source; };%s"
                  % (T, tag))
    c.body.append("%s observed = src_lambda(%s);" % (T, addr))
    return "observed"


def _r_func_ptr(c, T, ref, addr, tag):
    c.helper("static %s load_value(const %s* source) {\n"
             "    return *source;%s\n}" % (T, T, tag))
    c.body.append("%s (*src_fp)(const %s*) = load_value;" % (T, T))
    c.body.append("%s observed = src_fp(%s);" % (T, addr))
    return "observed"


def _r_template(c, T, ref, addr, tag):
    c.helper("template <typename V>\n"
             "static V load_generic(const V* source) {\n"
             "    return *source;%s\n}" % tag)
    c.body.append("%s observed = load_generic<%s>(%s);" % (T, T, addr))
    return "observed"


def _r_two_level(c, T, ref, addr, tag):
    c.helper("static %s load_inner(const %s* source) {\n"
             "    return *source;%s\n}" % (T, T, tag))
    c.helper("static %s load_outer(const %s* source) {\n"
             "    return load_inner(source);\n}" % (T, T))
    c.body.append("%s observed = load_outer(%s);" % (T, addr))
    return "observed"


READ_PATHS = [
    Path("direct", 1, _r_direct, "a plain read"),
    Path("local_ptr", 1, _r_local_ptr, "a read through a local pointer"),
    Path("function", 3, _r_function, "a read inside a reader function"),
    Path("reference", 3, _r_reference, "a read through a const reference parameter"),
    Path("lambda", 3, _r_lambda, "a read inside a lambda"),
    Path("func_ptr", 3, _r_func_ptr, "a read reached through a function pointer with a single target"),
    Path("template", 5, _r_template, "a read inside a function template instance"),
    Path("two_level", 3, _r_two_level, "a read two call levels down"),
]

# ======================================================================
# decorations - noise that must not be able to move either endpoint
# ======================================================================

class Decoration(object):
    def __init__(self, key, tier, before, between, after, note):
        self.key = key
        self.tier = tier
        self.before = before      # fn(case) emitted before the write
        self.between = between    # fn(case) emitted between write and read
        self.after = after        # fn(case) emitted after the read
        self.note = note


def _noop(c):
    pass


def _d_rand_scratch(c):
    c.inc("stdlib.h")
    c.body.append("int scratch = 0;")
    c.body.append("if (rand() % 2 == 0) { scratch = 1; } else { scratch = 2; }")
    c.body.append("(void) scratch;")


def _d_rand_pad_len(c):
    c.inc("stdlib.h")
    c.helper("static int pad_area[64];")
    c.body.append("int pad_rounds = rand() % 6;")
    c.body.append("int pad_sum = 0;")
    c.body.append("for (int r = 0; r < pad_rounds; ++r) {")
    c.body.append("    for (int i = 0; i < 64; ++i) { pad_sum += pad_area[i]; }")
    c.body.append("}")
    c.body.append("(void) pad_sum;")


def _d_static_pad_between(c):
    c.helper("static int pad_area[100];")
    c.body.append("int pad_sum = 0;")
    c.body.append("for (int r = 0; r < 3; ++r) {")
    c.body.append("    for (int i = 0; i < 100; ++i) { pad_sum += pad_area[i]; }")
    c.body.append("}")
    c.body.append("(void) pad_sum;")


def _d_heap_pad_between(c):
    c.body.append("int* pad_buf = new int[100];")
    c.body.append("for (int i = 0; i < 100; ++i) { pad_buf[i] = i; }")
    c.body.append("int pad_sum = 0;")
    c.body.append("for (int i = 0; i < 100; ++i) { pad_sum += pad_buf[i]; }")
    c.body.append("delete[] pad_buf;")
    c.body.append("(void) pad_sum;")


def _d_dead_store(c):
    c.body.append("int unused_sink = 0;")
    c.body.append("unused_sink = 314;")
    c.body.append("(void) unused_sink;")


def _d_trailing_write(c):
    # an extra write to the observed cell AFTER the read - creates WAR inside
    # one repetition, measured stable by pilot probe e02
    pass  # filled in by the builder, which knows the cell reference


def _d_unrelated_pair(c):
    c.body.append("int companion = 0;")
    c.body.append("companion = 271;")
    c.body.append("int companion_seen = companion;")
    c.body.append("(void) companion_seen;")


def _d_tick_branch(c):
    c.body.append("static int noise_tick = 0;")
    c.body.append("int scratch = 0;")
    c.body.append("if (noise_tick % 17 == 3) { scratch = 5; }")
    c.body.append("noise_tick = noise_tick + 1;")
    c.body.append("(void) scratch;")


def _d_short_pad(c):
    # 16 read accesses only - an order of magnitude below the smallest
    # WRITE_SAMPLE_BATCH, so no shadow memory clear can fall inside it.
    c.helper("static int pad_area[16];")
    c.body.append("int pad_sum = 0;")
    c.body.append("for (int i = 0; i < 16; ++i) { pad_sum += pad_area[i]; }")
    c.body.append("(void) pad_sum;")


DECORATIONS = [
    Decoration("none", 1, _noop, _noop, _noop,
               "no decoration"),
    Decoration("rand_scratch", 2, _d_rand_scratch, _noop, _noop,
               "a random branch that only ever touches an unrelated scratch variable"),
    Decoration("dead_store", 2, _d_dead_store, _noop, _noop,
               "a dead store to an unrelated variable"),
    Decoration("unrelated_pair", 2, _d_unrelated_pair, _noop, _noop,
               "a second, completely separate write/read pair on an unrelated variable"),
]


# ======================================================================
# split 1 builder: no volatility
# ======================================================================

TYPES = ["int", "long", "short", "unsigned int", "long long", "char"]


def build_no_case(number, storage, wpath, rpath, deco, T, value):
    c = Case()
    ref, addr = storage.build(c, T)
    deco.before(c)
    wpath.build(c, T, ref, addr, value, "        // Sink")
    deco.between(c)
    result = rpath.build(c, T, ref, addr, "        // Source")
    deco.after(c)
    c.body.append("(void) %s;" % result)

    idea = (
        "The observed dependency runs from one fixed write instruction to one "
        "fixed read instruction over %s. The write is %s and the read is %s. %s "
        "Nothing in the program can make a different instruction take either "
        "end of the dependency, so the reported dependency structure cannot "
        "depend on which accesses a sampling window happens to catch."
        % (storage.note, wpath.note, rpath.note,
           ("Added noise: " + deco.note + ".") if deco.key != "none" else "")
    )
    expected = ("STABLE for every WRITE_SAMPLE_BATCH. Both endpoints are "
                "single instructions, so the union of observed dependencies is "
                "the same with and without sampling.")
    name = "case_%03d_none_no" % number
    src = c.render(name, number, 1,
                   "stable  - %s" % rpath.note,
                   "stable  - %s" % wpath.note,
                   idea, expected)
    tier = max(storage.tier, wpath.tier, rpath.tier, deco.tier)
    return name, src, tier

# ======================================================================
# rare-gate mechanisms for the _yes cases
#
# Each mechanism puts two or more candidate instructions on one end of the
# dependency and makes one of them rare, so that it has only two to four
# chances in a hundred repetitions to fall into a profiling window.
# ======================================================================

class Mechanism(object):
    def __init__(self, key, tier, emit, note, rare_note):
        self.key = key
        self.tier = tier
        self.emit = emit          # fn(case, T, ref, addr, val, P, R) -> result var or None
        self.note = note
        self.rare_note = rare_note


# ---------------------------- sink side ----------------------------

def _ys_rare_patch(c, T, ref, addr, val, P, R):
    c.body.append("%s = %s;                       // Sink (frequent)" % (ref, val))
    c.body.append("if (tick %% %d == %d) {" % (P, R))
    c.body.append("    %s = %s;                   // Sink (rare patch)" % (ref, val + 7))
    c.body.append("}")


def _ys_rare_branch(c, T, ref, addr, val, P, R):
    c.body.append("if (tick %% %d == %d) {" % (P, R))
    c.body.append("    %s = %s;                   // Sink (rare arm)" % (ref, val + 7))
    c.body.append("} else {")
    c.body.append("    %s = %s;                   // Sink (frequent arm)" % (ref, val))
    c.body.append("}")


def _ys_rare_function(c, T, ref, addr, val, P, R):
    c.helper("static void store_common(%s* target) {\n"
             "    *target = %s;                   // Sink (frequent)\n}" % (T, val))
    c.helper("static void store_rare(%s* target) {\n"
             "    *target = %s;                   // Sink (rare)\n}" % (T, val + 7))
    c.body.append("if (tick %% %d == %d) {" % (P, R))
    c.body.append("    store_rare(%s);" % addr)
    c.body.append("} else {")
    c.body.append("    store_common(%s);" % addr)
    c.body.append("}")


def _ys_rare_func_ptr(c, T, ref, addr, val, P, R):
    c.helper("static void store_common(%s* target) {\n"
             "    *target = %s;                   // Sink (frequent)\n}" % (T, val))
    c.helper("static void store_rare(%s* target) {\n"
             "    *target = %s;                   // Sink (rare)\n}" % (T, val + 7))
    c.body.append("void (*sink_fp)(%s*) = store_common;" % T)
    c.body.append("if (tick %% %d == %d) {" % (P, R))
    c.body.append("    sink_fp = store_rare;")
    c.body.append("}")
    c.body.append("sink_fp(%s);" % addr)


def _ys_rare_table_slot(c, T, ref, addr, val, P, R):
    c.helper("static void store_common(%s* target) {\n"
             "    *target = %s;                   // Sink (frequent)\n}" % (T, val))
    c.helper("static void store_rare(%s* target) {\n"
             "    *target = %s;                   // Sink (rare)\n}" % (T, val + 7))
    c.body.append("void (*sink_table[2])(%s*) = { store_common, store_rare };" % T)
    c.body.append("int sink_slot = (tick %% %d == %d) ? 1 : 0;" % (P, R))
    c.body.append("sink_table[sink_slot](%s);" % addr)


def _ys_rare_lambda(c, T, ref, addr, val, P, R):
    c.body.append("auto store_common = [](%s* target) { *target = %s; };"
                  "   // Sink (frequent)" % (T, val))
    c.body.append("auto store_rare = [](%s* target) { *target = %s; };"
                  "   // Sink (rare)" % (T, val + 7))
    c.body.append("if (tick %% %d == %d) {" % (P, R))
    c.body.append("    store_rare(%s);" % addr)
    c.body.append("} else {")
    c.body.append("    store_common(%s);" % addr)
    c.body.append("}")


def _ys_rare_switch(c, T, ref, addr, val, P, R):
    c.body.append("switch (tick %% %d) {" % P)
    c.body.append("case %d:" % R)
    c.body.append("    %s = %s;                   // Sink (rare arm)" % (ref, val + 7))
    c.body.append("    break;")
    c.body.append("case %d:" % ((R + 1) % P))
    c.body.append("    %s = %s;                   // Sink (second rare arm)" % (ref, val + 13))
    c.body.append("    break;")
    c.body.append("default:")
    c.body.append("    %s = %s;                   // Sink (default arm)" % (ref, val))
    c.body.append("    break;")
    c.body.append("}")


def _ys_rare_recursion(c, T, ref, addr, val, P, R):
    c.helper("static void store_descend(%s* target, int depth, int shallow) {\n"
             "    if (shallow != 0 && depth == 1) {\n"
             "        *target = %s;               // Sink (rare shallow stop)\n"
             "        return;\n"
             "    }\n"
             "    if (depth == 0) {\n"
             "        *target = %s;               // Sink (bottom of recursion)\n"
             "        return;\n"
             "    }\n"
             "    store_descend(target, depth - 1, shallow);\n}"
             % (T, val + 7, val))
    c.body.append("int sink_shallow = (tick %% %d == %d) ? 1 : 0;" % (P, R))
    c.body.append("store_descend(%s, 3, sink_shallow);" % addr)


def _ys_rare_alias(c, T, ref, addr, val, P, R):
    c.body.append("%s* sink_alias_main = %s;" % (T, addr))
    c.body.append("%s* sink_alias_rare = %s;" % (T, addr))
    c.body.append("if (tick %% %d == %d) {" % (P, R))
    c.body.append("    *sink_alias_rare = %s;          // Sink (rare alias)" % (val + 7))
    c.body.append("} else {")
    c.body.append("    *sink_alias_main = %s;          // Sink (frequent alias)" % val)
    c.body.append("}")


def _ys_rare_loop_shape(c, T, ref, addr, val, P, R):
    # writes the observed cell from one of two loop instructions
    c.body.append("if (tick %% %d == %d) {" % (P, R))
    c.body.append("    for (int i = 0; i < 16; i += 1) {")
    c.body.append("        if (i == 7) { %s = %s; } // Sink (rare dense loop)" % (ref, val + 7))
    c.body.append("    }")
    c.body.append("} else {")
    c.body.append("    for (int i = 0; i < 16; i += 7) {")
    c.body.append("        if (i == 7) { %s = %s; } // Sink (frequent sparse loop)" % (ref, val))
    c.body.append("    }")
    c.body.append("}")


SINK_MECHANISMS = [
    Mechanism("rare_patch", 2, _ys_rare_patch,
              "a frequent write plus a rare patch write",
              "the patch write line"),
    Mechanism("rare_branch", 2, _ys_rare_branch,
              "two write instructions in the arms of a rare/frequent branch",
              "the rare arm write line"),
    Mechanism("rare_function", 3, _ys_rare_function,
              "two writer functions, the second one called only rarely",
              "the write line inside the rare writer"),
    Mechanism("rare_func_ptr", 3, _ys_rare_func_ptr,
              "a function pointer that is rarely retargeted to a second writer",
              "the write line inside the rare target"),
    Mechanism("rare_table_slot", 3, _ys_rare_table_slot,
              "a two slot function pointer table whose second slot is selected only rarely",
              "the write line of the rare slot"),
    Mechanism("rare_lambda", 3, _ys_rare_lambda,
              "two lambdas, the second one invoked only rarely",
              "the write line inside the rare lambda"),
    Mechanism("rare_switch", 2, _ys_rare_switch,
              "a switch over the tick counter with two rare arms and one default arm",
              "the two rare arm write lines"),
    Mechanism("rare_recursion", 4, _ys_rare_recursion,
              "a recursive writer that rarely stops one level early, at a different write line",
              "the shallow stop write line"),
    Mechanism("rare_alias", 4, _ys_rare_alias,
              "two aliases of the same cell, the second one used only rarely",
              "the write line through the rare alias"),
    Mechanism("rare_loop_shape", 4, _ys_rare_loop_shape,
              "two loop shapes carrying two different write instructions",
              "the write line of the rare loop shape"),
]

# --------------------------- source side ---------------------------

def _yr_rare_extra(c, T, ref, addr, val, P, R):
    c.body.append("%s observed = %s;              // Source (frequent)" % (T, ref))
    c.body.append("if (tick %% %d == %d) {" % (P, R))
    c.body.append("    observed += %s;            // Source (rare extra read)" % ref)
    c.body.append("}")
    return "observed"


def _yr_rare_branch(c, T, ref, addr, val, P, R):
    c.body.append("%s observed = 0;" % T)
    c.body.append("if (tick %% %d == %d) {" % (P, R))
    c.body.append("    observed = %s + 1;         // Source (rare arm)" % ref)
    c.body.append("} else {")
    c.body.append("    observed = %s + 2;         // Source (frequent arm)" % ref)
    c.body.append("}")
    return "observed"


def _yr_rare_function(c, T, ref, addr, val, P, R):
    c.helper("static %s load_common(const %s* source) {\n"
             "    return *source + 1;             // Source (frequent)\n}" % (T, T))
    c.helper("static %s load_rare(const %s* source) {\n"
             "    return *source + 2;             // Source (rare)\n}" % (T, T))
    c.body.append("%s observed = 0;" % T)
    c.body.append("if (tick %% %d == %d) {" % (P, R))
    c.body.append("    observed = load_rare(%s);" % addr)
    c.body.append("} else {")
    c.body.append("    observed = load_common(%s);" % addr)
    c.body.append("}")
    return "observed"


def _yr_rare_func_ptr(c, T, ref, addr, val, P, R):
    c.helper("static %s load_common(const %s* source) {\n"
             "    return *source + 1;             // Source (frequent)\n}" % (T, T))
    c.helper("static %s load_rare(const %s* source) {\n"
             "    return *source + 2;             // Source (rare)\n}" % (T, T))
    c.body.append("%s (*src_fp)(const %s*) = load_common;" % (T, T))
    c.body.append("if (tick %% %d == %d) {" % (P, R))
    c.body.append("    src_fp = load_rare;")
    c.body.append("}")
    c.body.append("%s observed = src_fp(%s);" % (T, addr))
    return "observed"


def _yr_rare_table_slot(c, T, ref, addr, val, P, R):
    c.helper("static %s load_common(const %s* source) {\n"
             "    return *source + 1;             // Source (frequent)\n}" % (T, T))
    c.helper("static %s load_rare(const %s* source) {\n"
             "    return *source + 2;             // Source (rare)\n}" % (T, T))
    c.body.append("%s (*src_table[2])(const %s*) = { load_common, load_rare };" % (T, T))
    c.body.append("int src_slot = (tick %% %d == %d) ? 1 : 0;" % (P, R))
    c.body.append("%s observed = src_table[src_slot](%s);" % (T, addr))
    return "observed"


def _yr_rare_lambda(c, T, ref, addr, val, P, R):
    c.body.append("auto load_common = [](const %s* source) { return *source + 1; };"
                  "  // Source (frequent)" % T)
    c.body.append("auto load_rare = [](const %s* source) { return *source + 2; };"
                  "    // Source (rare)" % T)
    c.body.append("%s observed = 0;" % T)
    c.body.append("if (tick %% %d == %d) {" % (P, R))
    c.body.append("    observed = load_rare(%s);" % addr)
    c.body.append("} else {")
    c.body.append("    observed = load_common(%s);" % addr)
    c.body.append("}")
    return "observed"


def _yr_rare_switch(c, T, ref, addr, val, P, R):
    c.body.append("%s observed = 0;" % T)
    c.body.append("switch (tick %% %d) {" % P)
    c.body.append("case %d:" % R)
    c.body.append("    observed = %s + 1;         // Source (rare arm)" % ref)
    c.body.append("    break;")
    c.body.append("case %d:" % ((R + 1) % P))
    c.body.append("    observed = %s + 2;         // Source (second rare arm)" % ref)
    c.body.append("    break;")
    c.body.append("default:")
    c.body.append("    observed = %s + 3;         // Source (default arm)" % ref)
    c.body.append("    break;")
    c.body.append("}")
    return "observed"


def _yr_rare_recursion(c, T, ref, addr, val, P, R):
    c.helper("static %s load_descend(const %s* source, int depth, int shallow) {\n"
             "    if (shallow != 0 && depth == 1) {\n"
             "        return *source + 2;         // Source (rare shallow stop)\n"
             "    }\n"
             "    if (depth == 0) {\n"
             "        return *source + 1;         // Source (bottom of recursion)\n"
             "    }\n"
             "    return load_descend(source, depth - 1, shallow);\n}" % (T, T))
    c.body.append("int src_shallow = (tick %% %d == %d) ? 1 : 0;" % (P, R))
    c.body.append("%s observed = load_descend(%s, 3, src_shallow);" % (T, addr))
    return "observed"


def _yr_rare_alias(c, T, ref, addr, val, P, R):
    c.body.append("const %s* src_alias_main = %s;" % (T, addr))
    c.body.append("const %s* src_alias_rare = %s;" % (T, addr))
    c.body.append("%s observed = 0;" % T)
    c.body.append("if (tick %% %d == %d) {" % (P, R))
    c.body.append("    observed = *src_alias_rare;    // Source (rare alias)")
    c.body.append("} else {")
    c.body.append("    observed = *src_alias_main;    // Source (frequent alias)")
    c.body.append("}")
    return "observed"


def _yr_rare_loop_shape(c, T, ref, addr, val, P, R):
    c.body.append("%s observed = 0;" % T)
    c.body.append("if (tick %% %d == %d) {" % (P, R))
    c.body.append("    for (int i = 0; i < 16; i += 1) {")
    c.body.append("        if (i == 7) { observed += %s; } // Source (rare dense loop)" % ref)
    c.body.append("    }")
    c.body.append("} else {")
    c.body.append("    for (int i = 0; i < 16; i += 7) {")
    c.body.append("        if (i == 7) { observed += %s; } // Source (frequent sparse loop)" % ref)
    c.body.append("    }")
    c.body.append("}")
    return "observed"


SOURCE_MECHANISMS = [
    Mechanism("rare_extra", 2, _yr_rare_extra,
              "a frequent read plus a rare extra read of the same cell",
              "the extra read line"),
    Mechanism("rare_branch", 2, _yr_rare_branch,
              "two read instructions in the arms of a rare/frequent branch",
              "the rare arm read line"),
    Mechanism("rare_function", 3, _yr_rare_function,
              "two reader functions, the second one called only rarely",
              "the read line inside the rare reader"),
    Mechanism("rare_func_ptr", 3, _yr_rare_func_ptr,
              "a function pointer that is rarely retargeted to a second reader",
              "the read line inside the rare target"),
    Mechanism("rare_table_slot", 3, _yr_rare_table_slot,
              "a two slot function pointer table whose second slot is selected only rarely",
              "the read line of the rare slot"),
    Mechanism("rare_lambda", 3, _yr_rare_lambda,
              "two lambdas, the second one invoked only rarely",
              "the read line inside the rare lambda"),
    Mechanism("rare_switch", 2, _yr_rare_switch,
              "a switch over the tick counter with two rare arms and one default arm",
              "the two rare arm read lines"),
    Mechanism("rare_recursion", 4, _yr_rare_recursion,
              "a recursive reader that rarely stops one level early, at a different read line",
              "the shallow stop read line"),
    Mechanism("rare_alias", 4, _yr_rare_alias,
              "two aliases of the same cell, the second one read only rarely",
              "the read line through the rare alias"),
    Mechanism("rare_loop_shape", 4, _yr_rare_loop_shape,
              "two loop shapes carrying two different read instructions",
              "the read line of the rare loop shape"),
]


# ======================================================================
# distance levers
# ======================================================================

class Distance(object):
    def __init__(self, key, tier, emit, note):
        self.key = key
        self.tier = tier
        self.emit = emit
        self.note = note


def _dist_none(c):
    pass


def _dist_pad_writes(rounds, width):
    def emit(c):
        c.helper("static int pad_area[%d];\n\n"
                 "static void pad_writes(int rounds) {\n"
                 "    for (int r = 0; r < rounds; ++r) {\n"
                 "        for (int i = 0; i < %d; ++i) {\n"
                 "            pad_area[i] = r ^ i;\n"
                 "        }\n"
                 "    }\n}" % (width, width))
        c.body.append("pad_writes(%d);" % rounds)
    return emit


def _dist_pad_reads(rounds, width):
    def emit(c):
        c.helper("static int pad_area[%d];\n\n"
                 "static int pad_reads(int rounds) {\n"
                 "    int sum = 0;\n"
                 "    for (int r = 0; r < rounds; ++r) {\n"
                 "        for (int i = 0; i < %d; ++i) {\n"
                 "            sum += pad_area[i];\n"
                 "        }\n"
                 "    }\n"
                 "    return sum;\n}" % (width, width))
        c.body.append("int pad_noise = pad_reads(%d);" % rounds)
        c.body.append("(void) pad_noise;")
    return emit


DISTANCES = [
    Distance("none", 1, _dist_none, "no additional distance"),
    Distance("pad_writes_small", 2, _dist_pad_writes(8, 32),
             "256 padding writes, enough to cross the smaller sampling windows"),
    Distance("pad_writes_large", 3, _dist_pad_writes(40, 64),
             "2560 padding writes, which guarantee a shadow memory clear for every batch size"),
    Distance("pad_reads_small", 2, _dist_pad_reads(8, 32),
             "256 padding reads, enough to cross the smaller sampling windows"),
    Distance("pad_reads_large", 3, _dist_pad_reads(40, 64),
             "2560 padding reads, which shift the window phase from repetition to repetition"),
]

RARITY = [(19, 5), (23, 11), (29, 9), (31, 17), (37, 11), (41, 23),
          (23, 4), (29, 19), (31, 7), (37, 29), (41, 13), (19, 12)]


def _tick_open(c):
    c.body.append("static int tick = 0;")


def _tick_close(c, result):
    c.body.append("tick = tick + 1;")
    if result:
        c.body.append("(void) %s;" % result)


def build_sinkvol_case(number, storage, mech, rpath, dist, T, val, P, R):
    c = Case()
    _tick_open(c)
    ref, addr = storage.build(c, T)
    mech.emit(c, T, ref, addr, val, P, R)
    dist.emit(c)
    result = rpath.build(c, T, ref, addr, "        // Source")
    _tick_close(c, result)

    idea = (
        "The sink end offers more than one candidate write instruction: %s. "
        "The gate tick %% %d == %d fires on about %d of the 100 repetitions, so "
        "%s gets very few chances to fall inside a profiling window. The read "
        "end is a single instruction - %s over %s - so only the write end of "
        "the dependency can change identity. %s"
        % (mech.note, P, R, 100 // P, mech.rare_note, rpath.note, storage.note,
           ("Distance lever: " + dist.note + ".") if dist.key != "none" else
           "No distance lever is used; rarity alone carries the case.")
    )
    expected = (
        "VOLATILE for at least one WRITE_SAMPLE_BATCH. %s is expected to be the "
        "first edge to disappear from the sampled dependency set, which leaves "
        "the same read instruction paired with a smaller set of write "
        "instructions than in the baseline."
        % mech.rare_note.capitalize()
    )
    name = "case_%03d_sinkvol_yes" % number
    src = c.render(name, number, 2,
                   "stable   - %s" % rpath.note,
                   "VOLATILE - %s" % mech.note,
                   idea, expected)
    return name, src, max(storage.tier, mech.tier, rpath.tier, dist.tier)


def build_srcvol_case(number, storage, wpath, mech, dist, T, val, P, R):
    c = Case()
    _tick_open(c)
    ref, addr = storage.build(c, T)
    # The distance lever sits in FRONT of the write on purpose: a shadow memory
    # clear between write and read would attack the sink end as well and would
    # turn this into a split 4 case.  In front of the write it only shifts the
    # window phase from repetition to repetition.
    dist.emit(c)
    wpath.build(c, T, ref, addr, val, "        // Sink")
    result = mech.emit(c, T, ref, addr, val, P, R)
    _tick_close(c, result)

    idea = (
        "The source end offers more than one candidate read instruction: %s. "
        "The gate tick %% %d == %d fires on about %d of the 100 repetitions, so "
        "%s gets very few chances to fall inside a profiling window. The write "
        "end is a single instruction - %s over %s - so only the read end of the "
        "dependency can change identity. %s The padding is deliberately placed "
        "in front of the write, so that no shadow memory clear can fall between "
        "write and read and the sink end stays untouched."
        % (mech.note, P, R, 100 // P, mech.rare_note, wpath.note, storage.note,
           ("Distance lever: " + dist.note + ".") if dist.key != "none" else
           "No distance lever is used; rarity alone carries the case.")
    )
    expected = (
        "VOLATILE for at least one WRITE_SAMPLE_BATCH. %s is expected to be the "
        "first key to vanish from the sampled dependency file, which leaves the "
        "same write instruction paired with a smaller set of read instructions "
        "than in the baseline."
        % mech.rare_note.capitalize()
    )
    name = "case_%03d_srcvol_yes" % number
    src = c.render(name, number, 3,
                   "VOLATILE - %s" % mech.note,
                   "stable   - %s" % wpath.note,
                   idea, expected)
    return name, src, max(storage.tier, mech.tier, wpath.tier, dist.tier)


def build_bothvol_case(number, storage, smech, rmech, dist, T, val, P1, R1, P2, R2):
    c = Case()
    _tick_open(c)
    ref, addr = storage.build(c, T)
    smech.emit(c, T, ref, addr, val, P1, R1)
    dist.emit(c)
    result = rmech.emit(c, T, ref, addr, val, P2, R2)
    _tick_close(c, result)

    idea = (
        "Both ends of the dependency carry more than one candidate "
        "instruction. On the sink side: %s, gated by tick %% %d == %d. On the "
        "source side: %s, gated by tick %% %d == %d. The two periods are "
        "coprime, so the rare write and the rare read almost never coincide and "
        "the pair of endpoints wanders over four combinations across the 100 "
        "repetitions. The cell itself is %s. %s"
        % (smech.note, P1, R1, rmech.note, P2, R2, storage.note,
           ("Distance lever: " + dist.note + ".") if dist.key != "none" else
           "No distance lever is used; rarity on both ends carries the case.")
    )
    expected = (
        "VOLATILE for at least one WRITE_SAMPLE_BATCH. %s and %s are both "
        "expected to be under-reported under sampling, so both the key and the "
        "value side of the dependency record change."
        % (smech.rare_note.capitalize(), rmech.rare_note)
    )
    name = "case_%03d_bothvol_yes" % number
    src = c.render(name, number, 4,
                   "VOLATILE - %s" % rmech.note,
                   "VOLATILE - %s" % smech.note,
                   idea, expected)
    return name, src, max(storage.tier, smech.tier, rmech.tier, dist.tier)


# ======================================================================
# driver
# ======================================================================

def load_existing_keys(dirs):
    keys = set()
    for d in dirs:
        for root, _dirs, files in os.walk(d):
            for f in files:
                if f.endswith(".cpp"):
                    with open(os.path.join(root, f)) as fh:
                        keys.add(structural_key(fh.read()))
    return keys


def emit(name, src):
    d = os.path.join(TARGET, name)
    os.makedirs(d)
    with open(os.path.join(d, name + ".cpp"), "w") as f:
        f.write(src)
    with open(os.path.join(d, "CMakeLists.txt"), "w") as f:
        f.write("cmake_minimum_required(VERSION 3.4.3)\n"
                "project(DiscoPoP_cmake_example)\n\n"
                "add_executable(cmake_example %s.cpp)\n" % name)


def main():
    import itertools
    import random

    seen = load_existing_keys(EXISTING_DIRS)
    sys.stderr.write("loaded %d existing structural keys\n" % len(seen))

    rng = random.Random(20260911)
    produced = []
    stats = {}

    def combo_tier(combo):
        return max([getattr(x, "tier", 1) for x in combo] or [1])

    def take(combos, count, builder, label):
        rng.shuffle(combos)
        buckets = {}
        for combo in combos:
            buckets.setdefault(combo_tier(combo), []).append(combo)
        tiers = sorted(buckets)
        # round robin over the tiers so every complexity tier is represented
        ordered = []
        i = 0
        while len(ordered) < len(combos):
            added = False
            for t in tiers:
                if i < len(buckets[t]):
                    ordered.append(buckets[t][i])
                    added = True
            if not added:
                break
            i += 1
        combos = ordered
        made = 0
        for combo in combos:
            if made >= count:
                break
            number = next_number[0]
            name, src, tier = builder(number, *combo)
            key = structural_key(src)
            if key in seen:
                continue
            seen.add(key)
            emit(name, src)
            axes = "\t".join(getattr(x, "key", str(x)) for x in combo)
            manifest.append("%s\t%s\t%d\t%s" % (name, label, tier, axes))
            produced.append((name, tier))
            stats.setdefault(label, []).append(tier)
            next_number[0] += 1
            made += 1
        if made < count:
            raise SystemExit("only produced %d of %d %s cases" % (made, count, label))

    next_number = [101]
    manifest = []

    # ---- split 1: 276 no-volatility cases ----
    no_combos = []
    for si, storage in enumerate(STORAGES):
        for wi, wpath in enumerate(WRITE_PATHS):
            for ri, rpath in enumerate(READ_PATHS):
                for di, deco in enumerate(DECORATIONS):
                    for ti, T in enumerate(TYPES):
                        no_combos.append((storage, wpath, rpath, deco, T,
                                          20 + ((si + wi + ri + di + ti) % 60)))
    take(no_combos, 276, build_no_case, "none_no")

    # ---- split 2: 75 sink volatile cases ----
    sink_combos = []
    for si, storage in enumerate(STORAGES):
        for mi, mech in enumerate(SINK_MECHANISMS):
            for ri, rpath in enumerate(READ_PATHS):
                for di, dist in enumerate(DISTANCES):
                    for ti, T in enumerate(TYPES):
                        P, R = RARITY[(si + mi + ri + di + ti) % len(RARITY)]
                        sink_combos.append((storage, mech, rpath, dist, T,
                                            20 + ((si * 7 + mi * 3 + ti) % 60),
                                            P, R))
    take(sink_combos, 75, build_sinkvol_case, "sinkvol_yes")

    # ---- split 3: 75 source volatile cases ----
    src_combos = []
    for si, storage in enumerate(STORAGES):
        for wi, wpath in enumerate(WRITE_PATHS):
            for mi, mech in enumerate(SOURCE_MECHANISMS):
                for di, dist in enumerate(DISTANCES):
                    for ti, T in enumerate(TYPES):
                        P, R = RARITY[(si + wi + mi + di + ti) % len(RARITY)]
                        src_combos.append((storage, wpath, mech, dist, T,
                                           20 + ((si * 5 + wi * 3 + ti) % 60),
                                           P, R))
    take(src_combos, 75, build_srcvol_case, "srcvol_yes")

    # ---- split 4: 74 both volatile cases ----
    both_combos = []
    for si, storage in enumerate(STORAGES):
        for mi, smech in enumerate(SINK_MECHANISMS):
            for ri, rmech in enumerate(SOURCE_MECHANISMS):
                for di, dist in enumerate(DISTANCES):
                    for ti, T in enumerate(TYPES):
                        P1, R1 = RARITY[(si + mi + ti) % len(RARITY)]
                        P2, R2 = RARITY[(ri + di + ti + 5) % len(RARITY)]
                        if P1 == P2:
                            continue
                        both_combos.append((storage, smech, rmech, dist, T,
                                            20 + ((si * 3 + mi * 5 + ri) % 60),
                                            P1, R1, P2, R2))
    take(both_combos, 74, build_bothvol_case, "bothvol_yes")

    with open(os.path.join(TARGET, "manifest.tsv"), "w") as f:
        f.write("\n".join(manifest) + "\n")
    sys.stderr.write("produced %d cases\n" % len(produced))
    for label, tiers in sorted(stats.items()):
        hist = {}
        for t in tiers:
            hist[t] = hist.get(t, 0) + 1
        sys.stderr.write("  %-14s %3d  tiers %s\n" % (label, len(tiers), sorted(hist.items())))


if __name__ == "__main__":
    shutil.rmtree(TARGET, ignore_errors=True)
    os.makedirs(TARGET)
    main()
