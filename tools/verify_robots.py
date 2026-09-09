#!/usr/bin/env python3
"""Verify every robot file in robots/ byte-for-byte against the live site."""
import importlib.util, os
from concurrent.futures import ThreadPoolExecutor, as_completed
from urllib.request import urlopen

spec = importlib.util.spec_from_file_location("dl", "tools/download_robots.py")
dl = importlib.util.module_from_spec(spec)
spec.loader.exec_module(dl)

body = urlopen(dl.INDEX, timeout=30).read()
entries = dl.parse_index(body)


def get(url, tries=3):
    last = None
    for i in range(tries):
        try:
            return urlopen(url, timeout=30).read()
        except Exception as e:
            last = e
    raise last


def check(item):
    sec, name, rid = item
    url = dl.BASE + "src2html/robot.php?id=" + rid
    remote = get(url)
    disk = open(f"robots/{sec}/{name}", "rb").read()
    return (sec, name, rid, remote == disk, len(remote), len(disk), None)


def check_exc(item, exc):
    return (item[0], item[1], item[2], False, 0, 0, str(exc))


bad = fetch_failed = 0
with ThreadPoolExecutor(max_workers=4) as pool:
    futures = [pool.submit(check, e) for e in entries]
    for fut in as_completed(futures):
        try:
            sec, name, rid, ok, rl, dl_, err = fut.result()
        except Exception as exc:
            sec, name, rid, ok, rl, dl_, err = check_exc(futures and (None, None, None), exc)
            bad += 1
            continue
        if not ok:
            bad += 1
        if err:
            fetch_failed += 1
            print(f"fetch problem: robots/{sec}/{name}: {err}")

print(f"checked {len(entries)} files: {len(entries) - bad} identical, {bad} mismatched")
print("RESULT:", "ALL CORRECT" if bad == 0 else "PROBLEMS FOUND")
