# LLVM-IR classifier datasets

The dataset builders extract program-level LLVM-IR features and binary labels
from the volatility benchmarks. Set up the classifier environment once:

```bash
venv/bin/python -m venv Classifier/venv
Classifier/venv/bin/python -m pip install -r Classifier/requirements.txt
```

The requirements include `ir2vec==2.1.1`, which is required by the real
IR2Vec embedding builder below.

Then run either builder from the repository root:

```bash
# Existing opcode/structure baseline
Classifier/venv/bin/python Classifier/pipeline/ir2vec.py

# Real IR2Vec program embeddings
Classifier/venv/bin/python Classifier/pipeline/real_ir2vec.py

# ProGraML graph-structure baseline
Classifier/venv/bin/python Classifier/pipeline/programl_features.py
```

The first command writes:

- `Classifier/dataset/features.csv`: one row per benchmark and 23
  aggregate instruction/structure features.
- `Classifier/dataset/labels.csv`: one binary label per benchmark (`yes` or
  `no`). The volatility split in the filename is intentionally ignored.

The ProGraML command writes the same schema to
`Classifier/dataset/programl_features.csv` and
`Classifier/dataset/programl_labels.csv`. Its features are deterministic
counts of ProGraML node/edge kinds, graph size, function/module structure, and
instruction opcodes. ProGraML is a graph representation, not a pretrained
embedding like IR2Vec, so this provides a graph-structure comparison. It
requires the `programl==0.3.2` package. The upstream release only publishes
x86_64 macOS and Linux wheels. On Apple Silicon, use an x86_64 Python under
Rosetta or run this extractor on an x86_64 Linux/macOS environment.

```bash
Classifier/venv/bin/pip install programl==0.3.2
```

Input paths can be overridden with `--ir-dir` and `--output-dir`.

## Train a first classifier

The generated CSV files are a supervised-learning table: each row is one
program, `features.csv` contains the LLVM-IR features, and `labels.csv`
contains the matching binary label. Train a scaled, class-balanced logistic
regression baseline with:

```bash
Classifier/venv/bin/python Classifier/pipeline/train_classifier.py
```

To train on the ProGraML dataset instead:

```bash
Classifier/venv/bin/python Classifier/pipeline/train_classifier.py \
  --features Classifier/dataset/programl_features.csv \
  --labels Classifier/dataset/programl_labels.csv \
  --model-output Classifier/dataset/programl_classifier.joblib
```

The script:

- joins features and labels using `case_id`;
- excludes `case_id` and `ir_file` from the model;
- uses a stratified holdout split and 5-fold cross-validation;
- prints accuracy, balanced accuracy, ROC-AUC, a classification report, and a
  confusion matrix; and
- saves the model and feature-column order to
  `Classifier/dataset/classifier.joblib`.

The dataset is small and imbalanced (many more `yes` than `no` examples), so
balanced accuracy and per-class recall are more informative than plain
accuracy. Treat the reported scores as an initial baseline, not as a reliable
estimate of generalization. Keep benchmarks from the same source family in
the same split or use a grouped split if you later add related programs.

To classify another feature row after training:

```python
import joblib
import pandas as pd

bundle = joblib.load("Classifier/dataset/classifier.joblib")
row = pd.read_csv("new_features.csv")[bundle["feature_columns"]]
print(bundle["model"].predict(row))
print(bundle["model"].predict_proba(row)[:, 1])
```
