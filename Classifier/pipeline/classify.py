import argparse
from pathlib import Path

import joblib
import pandas as pd

from real_ir2vec import extract_ir2vec_features

MODEL_PATH = Path(__file__).resolve().parents[1] / "models" / "classifier.joblib"


def classify_ir(ir_file: Path) -> str:
    """Extract IR2Vec features and classify the LLVM IR in the given file."""
    bundle = joblib.load(MODEL_PATH)
    if not isinstance(bundle, dict) or "model" not in bundle or "feature_columns" not in bundle:
        raise ValueError(f"Unsupported classifier bundle format: {MODEL_PATH}")

    feature_columns = bundle["feature_columns"]
    embedding = extract_ir2vec_features(str(ir_file))
    if len(embedding) != len(feature_columns):
        raise ValueError(
            f"IR2Vec produced {len(embedding)} features, "
            f"but the model expects {len(feature_columns)}."
        )

    features = pd.DataFrame([embedding], columns=feature_columns)
    return str(bundle["model"].predict(features)[0])


def main() -> None:
    parser = argparse.ArgumentParser(description="Classify an LLVM IR file.")
    parser.add_argument("file", type=Path, help="Path to the LLVM IR file")
    args = parser.parse_args()
    print(classify_ir(args.file))


if __name__ == "__main__":
    main()
