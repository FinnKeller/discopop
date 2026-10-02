#!/usr/bin/env python3
"""Run ir2vec.initEmbedding on a single .ll file and print the result or the full error.

Usage:
  python test_ir2vec.py path/to/file.ll [--mode fa|sym] [--level p|f]
  python test_ir2vec.py path/to/llvmir_dir/          # uses the first .ll found
"""
import argparse
import sys
import traceback
from pathlib import Path

import ir2vec


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("path", help=".ll file or a directory containing .ll files")
    ap.add_argument("--mode", default="fa", choices=["fa", "sym"])
    ap.add_argument("--level", default="p", choices=["p", "f"])
    args = ap.parse_args()

    p = Path(args.path).resolve()
    if p.is_dir():
        files = sorted(p.glob("*.ll"))
        if not files:
            sys.exit(f"no .ll files in {p}")
        p = files[0]

    print(f"file:  {p}")
    print(f"mode:  {args.mode}, level: {args.level}")

    try:
        obj = ir2vec.initEmbedding(str(p), args.mode, args.level)
        if args.level == "p":
            vec = obj.getProgramVector()
            print(f"OK: program vector, dim = {len(vec)}")
            print("first 5 values:", list(vec[:5]))
        else:
            fvecs = obj.getFunctionVectors()
            print(f"OK: {len(fvecs)} function vectors")
            for name, vec in list(fvecs.items())[:3]:
                print(f"  {name}: dim = {len(vec)}")
    except Exception:
        print("FAILED:")
        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()
