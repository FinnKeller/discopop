"""Extract LLVM IR from the volatility benchmarks with clang.

A "case" is either
  * a single file  case_<N>[_*].cpp, or
  * a directory    case_<N>[_*]/  containing one or more .cpp files (recursively).

Every translation unit is compiled to bitcode, then all units of a case are
merged with llvm-link into a single textual .ll file, so downstream code
(IR2Vec) still sees exactly one module per case.
"""

from pathlib import Path
import json
import re
import shlex
import subprocess
import tempfile


PROJECT_ROOT = Path(__file__).resolve().parents[2]
SOURCE_DIR = PROJECT_ROOT / "LULESH"
OUTPUT_DIR = PROJECT_ROOT / "Classifier" / "llvmir" / "test_use"
CLANG = Path.home() / "opt" / "clang-16" / "bin" / "clang++"
LLVM_LINK = CLANG.parent / "llvm-link"

#LULESH
DEFAULT_FLAGS = ["-DUSE_MPI=0"]  # drop -fopenmp if omp.h is missing


CASE_RE = re.compile(r"case_(\d+)(?:_.*)?")
SOURCE_SUFFIXES = {".cpp", ".cc", ".cxx"}
# Only these flags are taken from compile_commands.json (include paths, defines, standard).
KEPT_FLAG_PREFIXES = ("-I", "-D", "-std", "-isystem", "-include", "-f", "-W")



def find_cases() -> dict[str, list[Path]]:
	"""Map case name -> list of source files."""
	all_sources = sorted(p for p in SOURCE_DIR.rglob("*") if p.suffix in SOURCE_SUFFIXES)
	# Flat project (sources directly in SOURCE_DIR): the whole directory is one case.
	if any(p.parent == SOURCE_DIR for p in all_sources):
		return {SOURCE_DIR.name.lower(): all_sources}
	# Otherwise: every subdirectory containing sources is its own case.
	cases: dict[str, list[Path]] = {}
	for d in sorted(p for p in SOURCE_DIR.iterdir() if p.is_dir()):
		sources = sorted(p for p in d.rglob("*") if p.suffix in SOURCE_SUFFIXES)
		if sources:
			cases[d.name] = sources
	return cases


TWO_TOKEN_FLAGS = {"-I", "-D", "-isystem", "-include", "-iquote", "-idirafter"}


def keep_flags(args: list[str]) -> list[str]:
	"""Filter a compile command down to flags that affect the IR content."""
	keep: list[str] = []
	it = iter(args)
	for a in it:
		if a in TWO_TOKEN_FLAGS:
			value = next(it, None)
			if value is not None:
				keep += [a, value]
		elif a.startswith(KEPT_FLAG_PREFIXES):
			keep.append(a)
	return keep


def flags_from_compile_commands(case_dir: Path) -> dict[Path, list[str]]:
	"""Per-file extra flags (-I, -D, -std, ...) if a compile_commands.json exists."""
	db = case_dir / "compile_commands.json"
	if not db.is_file():
		return {}
	flags: dict[Path, list[str]] = {}
	for entry in json.loads(db.read_text()):
		args = entry.get("arguments") or shlex.split(entry["command"])
		keep = keep_flags(args[1:])
		path = Path(entry["file"])
		if not path.is_absolute():
			path = Path(entry["directory"]) / path
		flags[path.resolve()] = keep
	return flags


def compile_to_bitcode(source: Path, output: Path, extra_flags: list[str]) -> None:
	subprocess.run(
		[
			str(CLANG),
			"-O0",
			"-c",
			"-emit-llvm",
			"-Xclang",
			"-disable-O0-optnone",
			*extra_flags,
			str(source),
			"-o",
			str(output),
		],
		check=True,
		capture_output=True,
		text=True,
	)


def extract_case(name: str, sources: list[Path], extra: dict[Path, list[str]] | None = None) -> None:
	output_file = OUTPUT_DIR / f"{name}.ll"
	if extra is None:
		extra = flags_from_compile_commands(sources[0].parent) if len(sources) > 1 else {}
	with tempfile.TemporaryDirectory() as tmp:
		bitcode_files = []
		for i, src in enumerate(sources):
			bc = Path(tmp) / f"{i}_{src.stem}.bc"
			compile_to_bitcode(src, bc, extra.get(src.resolve(), DEFAULT_FLAGS))
			bitcode_files.append(str(bc))
		if len(bitcode_files) == 1:
			cmd = [str(LLVM_LINK), "-S", bitcode_files[0], "-o", str(output_file)]
		else:
			cmd = [str(LLVM_LINK), "-S", *bitcode_files, "-o", str(output_file)]
		subprocess.run(cmd, check=True, capture_output=True, text=True)


def extract_llvm_ir() -> None:
	"""Compile every benchmark case into one LLVM IR module."""
	if not SOURCE_DIR.is_dir():
		raise FileNotFoundError(f"Source directory not found: {SOURCE_DIR}")
	for tool in (CLANG, LLVM_LINK):
		if not tool.is_file():
			raise FileNotFoundError(f"LLVM tool not found: {tool}")
	OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

	failures: list[tuple[str, str]] = []
	cases = find_cases()
	for name, sources in cases.items():
		try:
			extract_case(name, sources)
		except subprocess.CalledProcessError as exc:
			errors = [l for l in (exc.stderr or "").splitlines() if "error:" in l]
			failures.append((name, "\n    ".join(errors[:5]) or str(exc)))

	print(f"{len(cases) - len(failures)}/{len(cases)} cases extracted")
	for name, reason in failures:
		print(f"FAILED {name}: {reason}")


def extract_from_compile_commands(db_path: Path, name: str) -> None:
	"""Compile every file in a compile_commands.json and link them into <name>.ll."""
	flags = flags_from_compile_commands(db_path.parent)
	if not flags:
		raise FileNotFoundError(f"No entries found in {db_path}")
	OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
	extract_case(name, sorted(flags), flags)
	print(f"{name}: linked {len(flags)} translation units")


if __name__ == "__main__":
	import sys

	if len(sys.argv) == 3:  # extract_llvm_ir.py <compile_commands.json> <output_name>
		extract_from_compile_commands(Path(sys.argv[1]), sys.argv[2])
	else:
		extract_llvm_ir()