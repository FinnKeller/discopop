"""Feature extraction and dataset construction for the LLVM-IR classifier."""

import argparse
import re
from pathlib import Path

import pandas as pd
from llvmlite import binding

# Initialize LLVM
binding.initialize_native_target()
binding.initialize_native_asmprinter()

# Key LLVM IR instruction opcodes relevant for volatility / memory profiling
FEATURE_OPCODES = [
    'load', 'store', 'getelementptr', 'alloca',  # Memory accesses
    'br', 'switch', 'indirectbr',                 # Control flow
    'call', 'invoke',                            # Function calls
    'add', 'sub', 'mul', 'sdiv', 'udiv',          # Arithmetic
    'icmp', 'fcmp', 'phi', 'select'              # Conditionals / SSAs
]

OPCODE_TO_IDX = {op: i for i, op in enumerate(FEATURE_OPCODES)}
CASE_RE = re.compile(r"^(case_\d{3})_(none|sinkvol|srcvol|bothvol)_(yes|no)")


def _instruction_features(blocks: list[dict]) -> dict[str, float]:
    """Aggregate block-level opcode vectors and structural statistics."""
    instruction_count = sum(int(block["total_instructions"]) for block in blocks)
    block_count = len(blocks)
    feature_values = {
        f"opcode_{opcode}": sum(block["raw_vector"][index] for block in blocks)
        for index, opcode in enumerate(FEATURE_OPCODES)
    }
    feature_values["opcode_other"] = sum(
        block["raw_vector"][-1] for block in blocks
    )
    feature_values.update(
        {
            "instruction_count": instruction_count,
            "basic_block_count": block_count,
            "function_count": len({block["function"] for block in blocks}),
            "mean_block_instructions": (
                instruction_count / block_count if block_count else 0.0
            ),
        }
    )
    return feature_values

def extract_block_features(ll_filepath):
    with open(ll_filepath, "r") as f:
        llvm_ir = f.read()

    module = binding.parse_assembly(llvm_ir)
    records = []

    for func in module.functions:
        for block in func.blocks:
            # Feature vector initialized to zeros + 1 extra slot for 'other' opcodes
            vec = [0] * (len(FEATURE_OPCODES) + 1)
            total_instrs = 0
            for instr in block.instructions:
                total_instrs += 1
                op = instr.opcode
                idx = OPCODE_TO_IDX.get(op)
                vec[idx if idx is not None else -1] += 1
            # Normalize vector by total instructions in block (frequency distribution)
            norm_vec = [v / total_instrs for v in vec] if total_instrs > 0 else vec

            records.append({
                "function": func.name,
                "block_name": block.name,
                "total_instructions": total_instrs,
                "raw_vector": vec,
                "feature_vector": norm_vec
            })

    return pd.DataFrame(records)


def parse_case_metadata(ir_path: Path) -> dict[str, str] | None:
    """Return the case ID and binary volatility label from a benchmark filename."""
    match = CASE_RE.match(ir_path.stem)
    if match is None:
        return None
    case_id, _, label = match.groups()
    return {
        "case_id": case_id,
        "label": label,
    }


def build_dataset(ir_dir: Path, output_dir: Path) -> tuple[pd.DataFrame, pd.DataFrame]:
    """Build program-level features and binary labels from all benchmark files."""
    rows: list[dict[str, object]] = []
    excluded: list[dict[str, str]] = []
    seen_case_ids: set[str] = set()

    for ir_path in sorted(ir_dir.glob("*.ll")):
        metadata = parse_case_metadata(ir_path)
        if metadata is None:
            excluded.append({"file": ir_path.name, "reason": "unrecognized_filename"})
            continue
        if ir_path.stem.endswith("_wrapped"):
            excluded.append({"file": ir_path.name, "reason": "derived_duplicate"})
            continue
        if metadata["case_id"] in seen_case_ids:
            excluded.append({"file": ir_path.name, "reason": "duplicate_case_id"})
            continue

        block_df = extract_block_features(str(ir_path))
        blocks = block_df.to_dict("records")
        if not blocks:
            excluded.append({"file": ir_path.name, "reason": "empty_module"})
            continue
        seen_case_ids.add(metadata["case_id"])
        rows.append(
            {
                **metadata,
                "ir_file": str(ir_path),
                **_instruction_features(blocks),
            }
        )

    dataset = pd.DataFrame(rows).sort_values("case_id").reset_index(drop=True)
    feature_columns = [
        column
        for column in dataset.columns
        if column not in {"case_id", "label", "ir_file"}
    ]
    features = dataset[["case_id", "ir_file", *feature_columns]]
    labels = dataset[["case_id", "label"]]
    output_dir.mkdir(parents=True, exist_ok=True)
    features.to_csv(output_dir / "features.csv", index=False)
    labels.to_csv(output_dir / "labels.csv", index=False)
    return features, labels


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--ir-dir",
        type=Path,
        default=Path(__file__).resolve().parents[1] / "llvmir",
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        default=Path(__file__).resolve().parents[1] / "dataset",
    )
    args = parser.parse_args()
    features, labels = build_dataset(args.ir_dir, args.output_dir)
    print(f"Wrote {len(features)} programs and {len(features.columns) - 2} features.")
    print("Class counts:")
    print(labels["label"].value_counts().sort_index().to_string())


if __name__ == "__main__":
    main()