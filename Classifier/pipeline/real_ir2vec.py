"""Feature extraction and dataset construction for the LLVM-IR classifier (IR2Vec)."""

import argparse
import re
from pathlib import Path

import numpy as np
import pandas as pd

try:
    import ir2vec
except ImportError as exc:
    ir2vec = None
    IR2VEC_IMPORT_ERROR = exc
else:
    IR2VEC_IMPORT_ERROR = None

CASE_RE = re.compile(r"^(case_\d{3})_(none|sinkvol|srcvol|bothvol)_(yes|no)")

# IR2Vec settings
# mode:  "sym" (symbolic) or "fa" (flow-aware)
# level: "p" (program vector) or "f" (function vectors)
DEFAULT_MODE = "fa"
EMBEDDING_DIM = 300  # IR2Vec's default vocabulary yields 300-d vectors


def extract_ir2vec_features(ll_filepath: str, mode: str = DEFAULT_MODE) -> np.ndarray:
    """Return the IR2Vec program-level embedding for a .ll file."""
    if ir2vec is None:
        raise RuntimeError(
            "IR2Vec is not installed. Install the classifier dependencies with "
            "`Classifier/venv/bin/python -m pip install -r Classifier/requirements.txt`."
        ) from IR2VEC_IMPORT_ERROR
    init_obj = ir2vec.initEmbedding(ll_filepath, mode, "p")
    vector = np.asarray(init_obj.getProgramVector(), dtype=float)
    if vector.ndim != 1 or vector.size == 0 or not np.isfinite(vector).all():
        raise ValueError("IR2Vec returned an empty or non-finite vector")
    return vector


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


def build_dataset(
    ir_dir: Path, output_dir: Path, mode: str = DEFAULT_MODE
) -> tuple[pd.DataFrame, pd.DataFrame]:
    """Build IR2Vec program embeddings and binary labels from all benchmark files."""
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

        try:
            vector = extract_ir2vec_features(str(ir_path), mode)
        except Exception as exc:  # IR2Vec raises on unparsable / unsupported IR
            excluded.append(
                {"file": ir_path.name, "reason": f"ir2vec_failed: {exc}"}
            )
            continue

        seen_case_ids.add(metadata["case_id"])
        rows.append(
            {
                **metadata,
                "ir_file": str(ir_path),
                **{f"ir2vec_{i:03d}": float(v) for i, v in enumerate(vector)},
            }
        )

    if not rows:
        reason_counts = pd.Series(
            [item["reason"].split(":", 1)[0] for item in excluded],
            dtype="string",
        ).value_counts().to_dict()
        details = ", ".join(
            f"{reason}={count}" for reason, count in sorted(reason_counts.items())
        )
        raise RuntimeError(
            f"No usable .ll files found in {ir_dir}"
            + (f" ({details})" if details else "")
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
    if excluded:
        pd.DataFrame(excluded).to_csv(output_dir / "excluded.csv", index=False)
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
    parser.add_argument(
        "--mode",
        choices=["sym", "fa"],
        default=DEFAULT_MODE,
        help="IR2Vec encoding: symbolic (sym) or flow-aware (fa).",
    )
    args = parser.parse_args()
    features, labels = build_dataset(args.ir_dir, args.output_dir, args.mode)
    print(f"Wrote {len(features)} programs and {len(features.columns) - 2} features.")
    print("Class counts:")
    print(labels["label"].value_counts().sort_index().to_string())


if __name__ == "__main__":
    main()