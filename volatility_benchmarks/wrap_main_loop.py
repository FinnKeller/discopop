import sys
import re


def wrap_main_in_loop(source: str, repeat_count: str) -> str:
    # Find the opening brace of main().
    match = re.search(
        r'\bint\s+main\s*\([^)]*\)\s*\{',
        source
    )

    if not match:
        raise ValueError("Could not find 'int main(...) {' in source")

    brace_start = match.end() - 1

    # Find the matching closing brace.
    depth = 0
    body_end = None

    for i in range(brace_start, len(source)):
        c = source[i]

        if c == '{':
            depth += 1
        elif c == '}':
            depth -= 1

            if depth == 0:
                body_end = i
                break

    if body_end is None:
        raise ValueError("Could not find matching closing brace for main()")

    body_start = brace_start + 1

    main_body = source[body_start:body_end]

    # Remove only a final "return ..." from main.
    #
    # The return has to be removed because it would otherwise terminate
    # the first iteration of the loop.
    #
    # This intentionally only handles a return at the end of main.
    main_body = re.sub(
        r'\s*return\s+[^;]+;\s*$',
        '',
        main_body,
        flags=re.MULTILINE
    )

    # Keep everything before main exactly as it was.
    prefix = source[:brace_start + 1]

    # Keep everything after main exactly as it was.
    suffix = source[body_end:]

    # Insert the repetition loop directly into main().
    #
    # Do NOT move the body into another function.
    new_source = (
        prefix
        + "\n"
        + "    for (int __dp_repeat = 0; "
          f"__dp_repeat < {repeat_count}; "
          "++__dp_repeat) {\n"
        + main_body
        + "\n"
        + "    }\n"
        + suffix
    )

    return new_source


def main():
    if len(sys.argv) != 4:
        sys.stderr.write(
            "Usage: wrap_main_loop.py "
            "<input.cpp> <output.cpp> <repeat_count>\n"
        )
        sys.exit(1)

    input_path = sys.argv[1]
    output_path = sys.argv[2]
    repeat_count = sys.argv[3]

    with open(input_path, "r") as f:
        source = f.read()

    wrapped = wrap_main_in_loop(source, repeat_count)

    with open(output_path, "w") as f:
        f.write(wrapped)


if __name__ == "__main__":
    main()