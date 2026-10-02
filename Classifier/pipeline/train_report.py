"""Train and evaluate binary classifiers from the generated LLVM-IR dataset.

By default all model types are trained and compared. Results are printed and
also written to a Markdown report (plus a JSON file with the raw numbers).
"""

import argparse
import json
from datetime import datetime
from pathlib import Path

import joblib
import numpy as np
import pandas as pd
import sklearn
from sklearn.ensemble import RandomForestClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.svm import SVC
from sklearn.metrics import (
    accuracy_score,
    balanced_accuracy_score,
    classification_report,
    confusion_matrix,
    roc_auc_score,
)
from sklearn.model_selection import RepeatedStratifiedKFold, cross_val_score, train_test_split
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import StandardScaler

ALL_MODELS = ["logreg", "svm", "random_forest"]
LABELS = ["no", "yes"]  # sorted class order; "yes" is the positive class


def load_dataset(features_path: Path, labels_path: Path) -> tuple[pd.DataFrame, pd.Series, list[str]]:
    """Load and join features and labels using the stable case ID."""
    features = pd.read_csv(features_path)
    labels = pd.read_csv(labels_path)
    dataset = features.merge(labels, on="case_id", how="inner", validate="one_to_one")
    if len(dataset) != len(features) or len(dataset) != len(labels):
        raise ValueError("Every feature row must have exactly one matching label.")

    feature_columns = [
        column
        for column in features.columns
        if column not in {"case_id", "ir_file"}
    ]
    if not feature_columns:
        raise ValueError("No numeric feature columns found.")
    return dataset[feature_columns], dataset["label"], feature_columns


def make_classifier(model_name: str, random_state: int) -> object:
    """Return a scaled, class-balanced classifier of the requested type."""
    if model_name == "logreg":
        estimator = LogisticRegression(
            class_weight="balanced", max_iter=2000, random_state=random_state
        )
    elif model_name == "svm":
        # No probability=True: it runs an internal 5-fold calibration and is
        # much slower. ROC-AUC uses decision_function instead (see positive_scores).
        estimator = SVC(
            kernel="rbf",
            class_weight="balanced",
            random_state=random_state,
        )
    elif model_name == "random_forest":
        estimator = RandomForestClassifier(
            n_estimators=300,
            class_weight="balanced",
            random_state=random_state,
        )
    else:
        raise ValueError(f"Unknown model: {model_name}")

    return make_pipeline(StandardScaler(), estimator)


def positive_scores(classifier, x) -> np.ndarray:
    """Score for the positive class: probability if available, else decision function."""
    if hasattr(classifier, "predict_proba"):
        return classifier.predict_proba(x)[:, 1]
    return classifier.decision_function(x)


def evaluate_model(name, x, y, split, folds, random_state) -> dict:
    """Holdout evaluation + repeated stratified CV for a single model type."""
    x_train, x_test, y_train, y_test = split

    classifier = make_classifier(name, random_state)
    classifier.fit(x_train, y_train)
    predictions = classifier.predict(x_test)
    scores = positive_scores(classifier, x_test)

    cv_scores = cross_val_score(
        make_classifier(name, random_state),
        x,
        y,
        cv=folds,
        scoring="balanced_accuracy",
        n_jobs=-1,
    )

    return {
        "model": name,
        "holdout_accuracy": accuracy_score(y_test, predictions),
        "holdout_balanced_accuracy": balanced_accuracy_score(y_test, predictions),
        "holdout_roc_auc": roc_auc_score((y_test == "yes").astype(int), scores),
        "cv_balanced_accuracy_mean": float(cv_scores.mean()),
        "cv_balanced_accuracy_std": float(cv_scores.std()),
        "cv_n_scores": int(len(cv_scores)),
        "classification_report": classification_report(
            y_test, predictions, labels=LABELS, zero_division=0
        ),
        "confusion_matrix": confusion_matrix(y_test, predictions, labels=LABELS).tolist(),
    }


def build_report(args, x, y, feature_columns, results, best_name, saved_paths) -> str:
    """Render all results as a Markdown document."""
    n_splits, n_repeats = args.cv_splits, args.cv_repeats
    lines = [
        "# Classifier evaluation report",
        "",
        f"_Generated: {datetime.now():%Y-%m-%d %H:%M:%S}_",
        "",
        "## Setup",
        "",
        f"- Features file: `{args.features}`",
        f"- Labels file: `{args.labels}`",
        f"- Programs: {len(x)}",
        f"- Features: {len(feature_columns)}",
        f"- Holdout: {args.test_size:.0%} stratified split (random_state={args.random_state})",
        f"- Cross-validation: {n_splits}-fold x {n_repeats} repeats, "
        f"repeated stratified ({n_splits * n_repeats} scores per model), "
        "metric = balanced accuracy",
        f"- scikit-learn {sklearn.__version__}, pandas {pd.__version__}, numpy {np.__version__}",
        "",
        "Class counts:",
        "",
        "| Class | Count |",
        "|---|---|",
    ]
    for label, count in y.value_counts().sort_index().items():
        lines.append(f"| {label} | {count} |")

    lines += [
        "",
        "## Summary",
        "",
        "| Model | Holdout acc. | Holdout bal. acc. | Holdout ROC-AUC | CV bal. acc. (mean ± std) |",
        "|---|---|---|---|---|",
    ]
    for r in results:
        marker = " **(best)**" if r["model"] == best_name else ""
        lines.append(
            f"| {r['model']}{marker} "
            f"| {r['holdout_accuracy']:.3f} "
            f"| {r['holdout_balanced_accuracy']:.3f} "
            f"| {r['holdout_roc_auc']:.3f} "
            f"| {r['cv_balanced_accuracy_mean']:.3f} ± {r['cv_balanced_accuracy_std']:.3f} |"
        )
    lines += [
        "",
        f"Best model by cross-validated balanced accuracy: **{best_name}**.",
        "",
        "## Details per model",
    ]

    for r in results:
        cm = r["confusion_matrix"]
        lines += [
            "",
            f"### {r['model']}",
            "",
            "Classification report (holdout):",
            "",
            "```",
            r["classification_report"].rstrip(),
            "```",
            "",
            "Confusion matrix (rows = true, columns = predicted):",
            "",
            "| | pred no | pred yes |",
            "|---|---|---|",
            f"| **true no** | {cm[0][0]} | {cm[0][1]} |",
            f"| **true yes** | {cm[1][0]} | {cm[1][1]} |",
        ]

    lines += ["", "## Saved models", ""]
    for name, path in saved_paths.items():
        lines.append(f"- `{name}`: `{path}`")
    lines.append("")
    return "\n".join(lines)


def main() -> None:
    root = Path(__file__).resolve().parents[1] / "dataset"
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--features", type=Path, default=root / "features.csv")
    parser.add_argument("--labels", type=Path, default=root / "labels.csv")
    parser.add_argument(
        "--model-output",
        type=Path,
        default=root / "classifier.joblib",
        help="Where to save the best model (per-model files go next to it as "
        "<stem>_<model>.joblib).",
    )
    parser.add_argument(
        "--report",
        type=Path,
        default=root / "results.md",
        help="Markdown report path (a .json file with raw numbers is written next to it).",
    )
    parser.add_argument(
        "--models",
        nargs="+",
        choices=ALL_MODELS,
        default=ALL_MODELS,
        help="Which classifiers to train and evaluate (default: all).",
    )
    parser.add_argument("--test-size", type=float, default=0.25)
    parser.add_argument("--random-state", type=int, default=42)
    parser.add_argument("--cv-splits", type=int, default=10)
    parser.add_argument("--cv-repeats", type=int, default=20)
    args = parser.parse_args()

    x, y, feature_columns = load_dataset(args.features, args.labels)
    split = train_test_split(
        x,
        y,
        test_size=args.test_size,
        random_state=args.random_state,
        stratify=y,
    )
    folds = RepeatedStratifiedKFold(
        n_splits=args.cv_splits, n_repeats=args.cv_repeats, random_state=args.random_state
    )

    print(f"Programs: {len(x)} | Features: {len(feature_columns)}")
    print(f"Class counts:\n{y.value_counts().sort_index().to_string()}\n")

    results = []
    for name in args.models:
        print(f"Evaluating {name} ...")
        result = evaluate_model(name, x, y, split, folds, args.random_state)
        results.append(result)
        print(
            f"  holdout bal. acc {result['holdout_balanced_accuracy']:.3f} | "
            f"ROC-AUC {result['holdout_roc_auc']:.3f} | "
            f"CV bal. acc {result['cv_balanced_accuracy_mean']:.3f} "
            f"+/- {result['cv_balanced_accuracy_std']:.3f}"
        )

    best = max(results, key=lambda r: r["cv_balanced_accuracy_mean"])["model"]

    # Refit every model on all labeled data; save each, and the best as the default.
    saved_paths = {}
    args.model_output.parent.mkdir(parents=True, exist_ok=True)
    for name in args.models:
        final = make_classifier(name, args.random_state).fit(x, y)
        payload = {"model": final, "feature_columns": feature_columns, "model_name": name}
        path = args.model_output.with_name(f"{args.model_output.stem}_{name}{args.model_output.suffix}")
        joblib.dump(payload, path)
        saved_paths[name] = path
        if name == best:
            joblib.dump(payload, args.model_output)
    saved_paths[f"best ({best})"] = args.model_output

    report = build_report(args, x, y, feature_columns, results, best, saved_paths)
    args.report.parent.mkdir(parents=True, exist_ok=True)
    args.report.write_text(report, encoding="utf-8")
    args.report.with_suffix(".json").write_text(
        json.dumps(
            {
                "generated": datetime.now().isoformat(timespec="seconds"),
                "programs": len(x),
                "features": len(feature_columns),
                "best_model": best,
                "results": results,
            },
            indent=2,
        ),
        encoding="utf-8",
    )

    print(f"\nBest model (CV balanced accuracy): {best}")
    print(f"Report written to {args.report}")
    print(f"Raw results written to {args.report.with_suffix('.json')}")
    print(f"Best model saved to {args.model_output}")


if __name__ == "__main__":
    main()
