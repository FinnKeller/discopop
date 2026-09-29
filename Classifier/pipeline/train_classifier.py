"""Train and evaluate a binary classifier from the generated LLVM-IR dataset."""

import argparse
from pathlib import Path

import joblib
import pandas as pd
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
        # probability=True is needed for predict_proba / ROC-AUC below.
        # It fits an internal 5-fold calibration, so it's noticeably slower
        # than the plain decision-function SVM, but fine at this dataset size.
        estimator = SVC(
            kernel="rbf",
            class_weight="balanced",
            #probability=True,
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


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--features",
        type=Path,
        default=Path(__file__).resolve().parents[1] / "dataset" / "features.csv",
    )
    parser.add_argument(
        "--labels",
        type=Path,
        default=Path(__file__).resolve().parents[1] / "dataset" / "labels.csv",
    )
    parser.add_argument(
        "--model-output",
        type=Path,
        default=Path(__file__).resolve().parents[1] / "dataset" / "classifier.joblib",
    )
    parser.add_argument(
        "--model",
        choices=["logreg", "svm", "random_forest"],
        default="logreg",
        help="Which classifier to train and evaluate.",
    )
    parser.add_argument("--test-size", type=float, default=0.25)
    parser.add_argument("--random-state", type=int, default=42)
    parser.add_argument(
        "--compare-all",
        action="store_true",
        help="Also print 5-fold CV balanced accuracy for every model type.",
    )
    args = parser.parse_args()

    x, y, feature_columns = load_dataset(args.features, args.labels)
    x_train, x_test, y_train, y_test = train_test_split(
        x,
        y,
        test_size=args.test_size,
        random_state=args.random_state,
        stratify=y,
    )

    classifier = make_classifier(args.model, args.random_state)
    classifier.fit(x_train, y_train)
    predictions = classifier.predict(x_test)
    probabilities = classifier.predict_proba(x_test)[:, 1]

    print(f"Model: {args.model}")
    print(f"Programs: {len(x)}")
    print(f"Features: {len(feature_columns)}")
    print(f"Class counts:\n{y.value_counts().sort_index().to_string()}")
    print(f"\nHoldout accuracy: {accuracy_score(y_test, predictions):.3f}")
    print(f"Holdout balanced accuracy: {balanced_accuracy_score(y_test, predictions):.3f}")
    print(f"Holdout ROC-AUC: {roc_auc_score((y_test == 'yes').astype(int), probabilities):.3f}")
    print("\nClassification report:")
    print(classification_report(y_test, predictions, labels=["no", "yes"], zero_division=0))
    print("Confusion matrix (rows=true, columns=predicted; [no, yes]):")
    print(confusion_matrix(y_test, predictions, labels=["no", "yes"]))

    # Use repeated stratified k-fold cross-validation for more robust evaluation.
    folds = RepeatedStratifiedKFold(n_splits=10, n_repeats=20, random_state=args.random_state)
    cv_scores = cross_val_score(
        make_classifier(args.model, args.random_state),
        x,
        y,
        cv=folds,
        scoring="balanced_accuracy",
    )
    print(f"\n5-fold balanced accuracy ({args.model}): {cv_scores.mean():.3f} +/- {cv_scores.std():.3f}")

    if args.compare_all:
        print("\n--- Comparing all model types (5-fold balanced accuracy) ---")
        for name in ["logreg", "svm", "random_forest"]:
            scores = cross_val_score(
                make_classifier(name, args.random_state),
                x,
                y,
                cv=folds,
                scoring="balanced_accuracy",
            )
            print(f"{name:>13}: {scores.mean():.3f} +/- {scores.std():.3f}")

    # Refit on all available labeled data for later inference.
    classifier.fit(x, y)
    args.model_output.parent.mkdir(parents=True, exist_ok=True)
    joblib.dump(
        {"model": classifier, "feature_columns": feature_columns, "model_name": args.model},
        args.model_output,
    )
    print(f"\nSaved model to {args.model_output}")


if __name__ == "__main__":
    main()