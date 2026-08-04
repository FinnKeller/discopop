from collections import defaultdict, Counter
import re
import sys
import os

def get_dict(file_path):
    d = defaultdict(list)
    with open(file_path, 'r', encoding='utf-8') as r:
        for line_num, line in enumerate(r, 1):
            stripped = line.strip()
            if not stripped:
                continue
            parts = stripped.split(None, 1)
            key = parts[0]
            if "BGN" in stripped or "END" in stripped or key == "START":
                continue

            value = parts[1].strip() if len(parts) > 1 else ""
            d[key].append(value)
    return d

def normalize(value):
    value = re.sub(r'S\d+', 'S', value)
    value = re.sub(r'([A-Za-z0-9_]+)\(\d+\)', r'\1', value)

    return value

def compare_dicts(d1, d2):
    all_keys = sorted(set(d1) | set(d2))
    differences = {}

    for key in all_keys:
        v1 = [normalize(v) for v in d1.get(key, [])]
        v2 = [normalize(v) for v in d2.get(key, [])]

        counter1 = Counter(v1)
        counter2 = Counter(v2)

        if counter1 != counter2:
            lost = counter1 - counter2
            added = counter2 - counter1
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
            print(f"Found {len(diffs)} keys with dependency mismatches\n", file= out)

            for key, changes in diffs.items():
                print(f"Key: {key}", file=out)
                if changes['lost']:
                    for dep, count in changes['lost'].items():
                        print(f"  [-] LOST {count}x: {dep}",file=out)

                if changes['added']:
                    for dep, count in changes['added'].items():
                        print(f"  [+] WRONG/ADDED {count}x: {dep}",file=out)
                print("-" * 50,file=out)

if __name__ == "__main__":
    main()