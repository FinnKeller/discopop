from collections import defaultdict
import re
import sys
import os

def is_wrapper_artifact(key, value):
    if key.endswith("@0"):
        return True

    if "__dp_repeat" in key:
        return True

    if "__dp_repeat" in value:
        return True

    return False
def get_dict(file_path):
    d = defaultdict(list)

    with open(file_path, "r", encoding="utf-8") as r:
        for line in r:
            stripped = line.strip()

            if not stripped:
                continue

            parts = stripped.split(None, 1)
            key = parts[0]

            if (
                key == "START"
                or "BGN" in stripped
                or "END" in stripped
            ):
                continue

            value = parts[1].strip() if len(parts) > 1 else ""

            if is_wrapper_artifact(key, value):
                continue

            d[key].append(value)

    return d

def normalize(value):
    value = re.sub(r'S\d+', 'S', value)
    value = re.sub(r'([A-Za-z0-9_]+)\(\d+\)', r'\1', value)
    value = canonicalize_dependency_order(value)
    return value

def canonicalize_dependency_order(value):
    tokens = value.split()

    if not tokens:
        return value

    # NOM is metadata describing the whole dependency record.
    prefix = []

    if tokens[0] == "NOM":
        prefix = ["NOM"]
        tokens = tokens[1:]

    segments = []
    current = []

    dependency_types = {"INIT", "RAW", "WAR", "WAW"}

    for tok in tokens:
        if tok in dependency_types:
            if current:
                segments.append(current)
            current = [tok]
        else:
            current.append(tok)

    if current:
        segments.append(current)

    segments.sort(key=lambda x: " ".join(x))

    return " ".join(prefix + [
        token
        for segment in segments
        for token in segment
    ])

def compare_dicts(d1, d2):
    all_keys = sorted(set(d1) | set(d2))
    differences = {}

    for key in all_keys:
        # Compare unique dependency sets instead of frequency counts
        set1 = set(normalize(v) for v in d1.get(key, []))
        set2 = set(normalize(v) for v in d2.get(key, []))

        lost = set1 - set2
        added = set2 - set1

        # Mismatch if new unobserved dependencies appear, or if a key drops completely
        if lost or added:
            differences[key] = {'lost': lost, 'added': added}

    return differences

def main():
    if len(sys.argv) != 4:
        print(f"Usage: {sys.argv[0]} <no_sampling_file> <sampling_file> <case_name>")
        sys.exit(1)

    file_a, file_b, case_name = sys.argv[1], sys.argv[2], sys.argv[3]

    a = get_dict(file_a)
    b = get_dict(file_b)

    diffs = compare_dicts(a, b)
    output_dir = os.path.dirname(os.path.abspath(file_a))
    output_file = os.path.join(output_dir, f"output_{case_name}.txt")
    with open(output_file, "w", encoding="utf-8") as out:
        if not diffs:
            print("Equivalent after normalization.", file=out)
        else:
            print(f"Found {len(diffs)} keys with dependency mismatches\n", file=out)

            for key, changes in diffs.items():
                print(f"Key: {key}", file=out)
                if changes['lost']:
                    for dep in changes['lost']:
                        print(f"  [-] LOST: {dep}", file=out)

                if changes['added']:
                    for dep in changes['added']:
                        print(f"  [+] WRONG/ADDED: {dep}", file=out)
                print("-" * 50, file=out)

if __name__ == "__main__":
    main()