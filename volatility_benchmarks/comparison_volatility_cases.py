from collections import Counter, defaultdict
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
    # Stack variable ids are negative numbers, so the sign must be part of
    # the pattern - otherwise every stack variable looks changed between runs.
    value = re.sub(r'S-?\d+', 'S', value)
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


def parse_dependency_segments(record):
    tokens = record.split()
    if not tokens:
        return []
    if tokens[0] == "NOM":
        tokens = tokens[1:]

    segments = []
    for i in range(0, len(tokens) - 1, 2):
        dep_type = tokens[i]
        dep_value = tokens[i + 1]
        if dep_type in {"INIT", "RAW", "WAR", "WAW"} and "|" in dep_value:
            segments.append((dep_type, dep_value))
    return segments


def var_name_from_dep(dep_value):
    if "|" not in dep_value:
        return None
    return dep_value.rsplit("|", 1)[1]


def is_sampling_reset_artifact(lost_record, added_record):
    lost_segments = parse_dependency_segments(lost_record)
    added_segments = parse_dependency_segments(added_record)

    if not lost_segments or not added_segments:
        return False

    lost_wars = [dep_value for dep_type, dep_value in lost_segments if dep_type == "WAR"]
    if len(lost_wars) != 1:
        return False

    lost_war = lost_wars[0]
    lost_var = var_name_from_dep(lost_war)
    if lost_var is None:
        return False

    # Artifact signature: baseline deps for one variable are preserved, sampled
    # run only adds extra WAW edges for the same variable due to sampling resets.
    for dep_type, dep_value in lost_segments:
        var = var_name_from_dep(dep_value)
        if var != lost_var:
            return False

        if dep_type == "WAR":
            continue
        if dep_type == "INIT" and dep_value.startswith("0@0|"):
            continue

        return False

    lost_counter = Counter(lost_segments)
    added_counter = Counter(added_segments)

    for segment, count in lost_counter.items():
        if added_counter[segment] < count:
            return False

    has_init_zero = any(
        dep_type == "INIT" and dep_value.startswith("0@0|") and var_name_from_dep(dep_value) == lost_var
        for dep_type, dep_value in added_segments
    )
    has_same_war = any(dep_type == "WAR" and dep_value == lost_war for dep_type, dep_value in added_segments)
    if not has_same_war:
        return False

    extra_segments = []
    for segment, count in added_counter.items():
        extra_count = count - lost_counter.get(segment, 0)
        if extra_count > 0:
            extra_segments.extend([segment] * extra_count)

    if not extra_segments:
        return False

    return all(
        (
            dep_type == "WAW" and var_name_from_dep(dep_value) == lost_var
        )
        or (
            dep_type == "INIT"
            and dep_value.startswith("0@0|")
            and var_name_from_dep(dep_value) == lost_var
        )
        for dep_type, dep_value in extra_segments
    )


def filter_sampling_artifact_differences(lost, added):
    filtered_lost = set(lost)
    filtered_added = set(added)

    for lost_record in list(lost):
        for added_record in list(added):
            if is_sampling_reset_artifact(lost_record, added_record):
                filtered_lost.discard(lost_record)
                filtered_added.discard(added_record)

    return filtered_lost, filtered_added


def compare_dicts(d1, d2):
    all_keys = sorted(set(d1) | set(d2))
    differences = {}

    for key in all_keys:
        # Compare unique dependency sets instead of frequency counts
        set1 = set(normalize(v) for v in d1.get(key, []))
        set2 = set(normalize(v) for v in d2.get(key, []))

        lost = set1 - set2
        added = set2 - set1

        lost, added = filter_sampling_artifact_differences(lost, added)

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