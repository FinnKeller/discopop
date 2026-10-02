"""Extract LLVM IR from the automatic volatility benchmarks with clang 16."""

from pathlib import Path
import re
import subprocess


PROJECT_ROOT = Path(__file__).resolve().parents[2]
SOURCE_DIR = PROJECT_ROOT / "volatility_benchmarks" / "benchmarks" / "automatic"
OUTPUT_DIR = PROJECT_ROOT / "Classifier" / "llvmir"

# Must match the LLVM major version of the IR2Vec wheel (2.1.1 -> LLVM 16).
CLANG = Path.home() / "opt" / "clang-16" / "bin" / "clang"
MIN_CASE = 1                      # was 101; set back if you really want to skip cases < 101
EXTENSIONS = {".c", ".cpp", ".cc", ".cxx"}


def extract_llvm_ir() -> None:
	if not SOURCE_DIR.is_dir():
		raise FileNotFoundError(f"Source directory not found: {SOURCE_DIR}")
	if not CLANG.is_file():
		raise FileNotFoundError(f"clang not found: {CLANG}")

	sources = sorted(f for f in SOURCE_DIR.rglob("*") if f.suffix in EXTENSIONS)
	print(f"{len(sources)} source files with {sorted(EXTENSIONS)} under {SOURCE_DIR}")

	selected = []
	for f in sources:
		m = re.fullmatch(r"case_(\d+)(?:_.*)?", f.stem)
		if m and int(m.group(1)) >= MIN_CASE:
			selected.append(f)
	print(f"{len(selected)} match the case_N filter (N >= {MIN_CASE})")
	if not selected:
		raise SystemExit("Nothing to compile - check SOURCE_DIR, EXTENSIONS and MIN_CASE.")

	OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
	failures = []
	for f in selected:
		out = OUTPUT_DIR / f"{f.stem}.ll"
		r = subprocess.run(
			[str(CLANG), "-O0", "-S", "-emit-llvm", "-Xclang", "-disable-O0-optnone",
			 str(f), "-o", str(out)],
			capture_output=True, text=True,
		)
		if r.returncode != 0:
			failures.append((f.name, r.stderr.strip().splitlines()[:3]))

	print(f"done: {len(selected) - len(failures)} ok, {len(failures)} failed -> {OUTPUT_DIR}")
	for name, err in failures:
		print(f"  {name}: {' | '.join(err)}")


if __name__ == "__main__":
	extract_llvm_ir()
