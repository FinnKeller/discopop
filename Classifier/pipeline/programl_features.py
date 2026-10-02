"""Build a classifier dataset from ProGraML graphs generated from LLVM IR."""

import argparse
import re
from collections import Counter
from pathlib import Path

import pandas as pd

from real_ir2vec import parse_case_metadata

try:
    import programl
except ImportError:
    programl = None


INSTRUCTION_RE = re.compile(r"(?:%[\w.-]+\s*=\s*)?([A-Za-z][A-Za-z0-9.]*)")


def _enum_name(enum_type: object, value: int) -> str:
    """Return a protobuf enum name without depending on generated enum values."""
    return enum_type.Name(value).lower()  # type: ignore[attr-defined]


def _graph_features(graph: object) -> dict[str, float]:
    """Aggregate node, edge, and function statistics from a ProGraML graph."""
    nodes = graph.node  # type: ignore[attr-defined]
    edges = graph.edge  # type: ignore[attr-defined]
    functions = graph.function  # type: ignore[attr-defined]
    node_types = Counter(_enum_name(type(nodes[0]).Type, node.type) for node in nodes) if nodes else Counter()
    edge_types = Counter(_enum_name(type(edges[0]).Flow, edge.flow) for edge in edges) if edges else Counter()
    instruction_opcodes = Counter()
    function_instruction_counts = Counter()

    for node in nodes:
        if _enum_name(type(node).Type, node.type) != "instruction":
            continue
        match = INSTRUCTION_RE.match(node.text)
        if match:
            instruction_opcodes[match.group(1).lower()] += 1
        function_instruction_counts[node.function] += 1

    features: dict[str, float] = {
        "node_count": float(len(nodes)),
        "edge_count": float(len(edges)),
        "function_count": float(len(functions)),
        "module_count": float(len(graph.module)),  # type: ignore[attr-defined]
        "mean_node_degree": (2.0 * len(edges) / len(nodes)) if nodes else 0.0,
        "mean_instructions_per_function": (
            sum(function_instruction_counts.values()) / len(functions) if functions else 0.0
        ),
    }
    for node_type in ("instruction", "variable", "constant", "type"):
        features[f"node_{node_type}_count"] = float(node_types[node_type])
    for edge_type in ("control", "data", "call", "type"):
        features[f"edge_{edge_type}_count"] = float(edge_types[edge_type])
    for opcode, count in sorted(instruction_opcodes.items()):
        features[f"opcode_{opcode}"] = float(count)
    return features


def extract_programl_features(ll_filepath: Path) -> dict[str, float]:
    """Create a ProGraML graph from one LLVM-IR file and aggregate its features."""
    if programl is None:
        raise RuntimeError(
            "ProGraML is not installed. Install programl==0.3.2 in an environment "
            "with a supported ProGraML wheel before running this extractor."
        )
    graph = programl.from_llvm_ir(ll_filepath.read_text())
    return _graph_features(graph)


def build_dataset(ir_dir: Path, output_dir: Path) -> tuple[pd.DataFrame, pd.DataFrame]:
    """Build program-level ProGraML features and binary labels."""
    rows: list[dict[str, object]] = []
    seen_case_ids: set[str] = set()

    for ir_path in sorted(ir_dir.glob("*.ll")):
        metadata = parse_case_metadata(ir_path)
        if metadata is None or ir_path.stem.endswith("_wrapped"):
            continue
        if metadata["case_id"] in seen_case_ids:
            continue
        features = extract_programl_features(ir_path)
        seen_case_ids.add(metadata["case_id"])
        rows.append({**metadata, "ir_file": str(ir_path), **features})

    if not rows:
        raise ValueError(f"No valid LLVM-IR benchmark files found in {ir_dir}")
    dataset = pd.DataFrame(rows).sort_values("case_id").reset_index(drop=True)
    feature_columns = [column for column in dataset if column not in {"case_id", "label", "ir_file"}]
    features = dataset[["case_id", "ir_file", *feature_columns]].fillna(0.0)
    labels = dataset[["case_id", "label"]]
    output_dir.mkdir(parents=True, exist_ok=True)
    features.to_csv(output_dir / "programl_features.csv", index=False)
    labels.to_csv(output_dir / "programl_labels.csv", index=False)
    return features, labels


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--ir-dir", type=Path, default=Path(__file__).resolve().parents[1] / "llvmir" / "llvmir")
    parser.add_argument("--output-dir", type=Path, default=Path(__file__).resolve().parents[1] / "dataset")
    args = parser.parse_args()
    features, labels = build_dataset(args.ir_dir, args.output_dir)
    print(f"Wrote {len(features)} programs and {len(features.columns) - 2} ProGraML features.")
    print("Class counts:")
    print(labels["label"].value_counts().sort_index().to_string())


if __name__ == "__main__":
    main()
