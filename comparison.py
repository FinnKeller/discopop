from collections import defaultdict
import re

def get_dict(file): #txt file
    d = defaultdict(list)
    with open(file) as r:
        for line in r:
            line = (line.replace('@', " ")
                .replace('START', '0')
                .replace(':'," ")
                )
            stripped = line.strip()
            parts = stripped.split(None, 1)
            key = parts[0]
            value = parts[1].strip() if len(parts) > 1 else ""
            d[key].append(value)
    return d

def normalize(value):
    value = re.sub(r'S\d+', 'S', value)
    value = re.sub(
        r'(GEPRESULT_[A-Za-z0-9_]+)\(\d+\)',
        r'\1',
        value
    )

    return value

def normalize_dict(d):
    result = {}

    for key, values in d.items():
        normalized_values = [normalize(v) for v in values]

        result[key] = sorted(normalized_values)

    return result


def compare_dicts(file1, file2):
    d1 = file1 if isinstance(file1, dict) else get_dict(file1)
    d2 = file2 if isinstance(file2, dict) else get_dict(file2)

    d1 = normalize_dict((d1))
    d2 = normalize_dict((d2))

    all_keys = sorted(set(d1) | set(d2))

    differences = []

    for key in all_keys:
        v1 = d1.get(key)
        v2 = d2.get(key)

        if v1 != v2:
            differences.append((key, v1, v2))

    return differences


a = get_dict("dependency_files/non_sampling_dynamic_dependencies.txt")
b = get_dict("dependency_files/sampling_dynamic_dependencies.txt")


diffs = compare_dicts(a, b)

if not diffs:
    print("Equivalent after normalization.")
else:
    print(f"{len(diffs)} differing keys:")
    for key, left, right in diffs:
        print(f"\nKey {key}")
        print("A:", left)
        print("B:", right)



