"""Extract LLVM IR from the automatic volatility benchmarks with clang."""

from pathlib import Path
import re
import subprocess


PROJECT_ROOT = Path(__file__).resolve().parents[2]
SOURCE_DIR = PROJECT_ROOT / "volatility_benchmarks" / "benchmarks" / "lpp_test" / "generated_volatility"
OUTPUT_DIR = PROJECT_ROOT / "Classifier" / "llvmir"
CLANG = Path.home() / "opt" / "clang-16" / "bin" / "clang++"

def extract_llvm_ir() -> None:
	"""Compile each benchmark C source into LLVM IR."""
	if not SOURCE_DIR.is_dir():
		raise FileNotFoundError(f"Source directory not found: {SOURCE_DIR}")
	if not CLANG.is_file():
		raise FileNotFoundError(f"clang not found: {CLANG}")
	for source_file in sorted(SOURCE_DIR.rglob("*.cpp")):
		match = re.fullmatch(r"case_(\d+)(?:_.*)?", source_file.stem)
		if match is None or int(match.group(1)) < 101:
			continue
		output_file = OUTPUT_DIR / f"{source_file.stem}.ll"
		OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
		subprocess.run(
			[
				str(CLANG),
				"-O0",
				"-S",
				"-emit-llvm",
				"-Xclang",
				"-disable-O0-optnone",
				str(source_file),
				"-o",
				str(output_file),
			],
			check=True,
		)


if __name__ == "__main__":
	extract_llvm_ir()
