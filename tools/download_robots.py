#!/usr/bin/env python3
"""Download all CROBOTS robot sources from the official archive.

Scrapes the index at https://crobots.deepthought.it/home.php?page=src2html&link=1
(robot list organised by section: one folder per tournament year 1990-2025,
plus the category sections aminet, cplusplus, crobs, micro) and downloads
every robot source to <repo>/robots/<section>/<name>.

Usage:  python3 tools/download_robots.py [output-dir]
"""
import re
import sys
import html as htmllib
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from urllib.request import urlopen

BASE = "https://crobots.deepthought.it/"
INDEX = BASE + "home.php?page=src2html&link=1"
UA = {"User-Agent": "crobots-archive-mirror/1.0 (curl)"}

# sections on the page: years (1990-2025) and categories (aminet, cplusplus,
# crobs, micro); nav h3s appear before any entry and never win the
# nearest-preceding match, so a generic pattern is safe.
SECTION_RE = re.compile(r"<h3>([A-Za-z0-9]+)</h3>")
# one <li> per robot: name in <strong>, raw link id following it
ENTRY_RE = re.compile(
    r"<strong>(?P<name>[^<]+)</strong></a><span[^>]*>\(<a href=\"src2html/robot\.php\?id=(?P<id>[A-Za-z0-9]+)\""
)


def fetch(url):
    req = urlopen(url, timeout=30)
    body = req.read()
    req.close()
    return body


def parse_index(body):
    """Return list of (section, name, robot_id) in page order.

    section is the <h3> header each entry falls under: a year (1990-2025)
    or a category (aminet, cplusplus, crobs, micro). Each becomes its own
    destination folder.
    """
    text = body.decode("utf-8", errors="replace")
    # robot nav/sidebar headers that must NOT become folders
    nav = {"Content", "Tournaments", "King of The Hill", "Links", "Admin"}
    sec_positions = []
    for m in SECTION_RE.finditer(text):
        name = m.group(1).strip()
        if name not in nav:
            sec_positions.append((m.start(), name))
    entries = []
    for m in ENTRY_RE.finditer(text):
        section = None
        for pos, name in sec_positions:
            if pos < m.start():
                section = name
            else:
                break
        if section is None:
            continue
        name = htmllib.unescape(m.group("name")).strip()
        entries.append((section, name, m.group("id")))
    return entries


def download_one(entry, outdir):
    section, name, rid = entry
    dest = Path(outdir) / section / name
    dest.parent.mkdir(parents=True, exist_ok=True)
    data = fetch(BASE + "src2html/robot.php?id=" + rid)
    dest.write_bytes(data)
    return section, name, rid, len(data)


def main():
    outdir = Path(sys.argv[1]) if len(sys.argv) > 1 else \
        Path(__file__).resolve().parent.parent / "robots"
    index = fetch(INDEX)
    entries = parse_index(index)
    # de-duplicate identical (section, name) keeping first occurrence
    seen = set()
    unique = []
    for e in entries:
        key = (e[0], e[1])
        if key not in seen:
            seen.add(key)
            unique.append(e)
    print("found %d robots (%d unique) across %d sections"
          % (len(entries), len(unique), len({e[0] for e in unique})))
    failures = []
    ok = 0
    with ThreadPoolExecutor(max_workers=8) as pool:
        futures = [pool.submit(download_one, e, outdir) for e in unique]
        for fut in as_completed(futures):
            try:
                section, name, rid, size = fut.result()
                ok += 1
                if size < 40:
                    failures.append((section, name, rid, "suspiciously small: %d b" % size))
            except Exception as exc:  # noqa: BLE001
                failures.append((exc,))
    print("downloaded %d files to %s" % (ok, outdir))
    if failures:
        print("%d problems:" % len(failures))
        for f in failures:
            print("  ", f)
        sys.exit(1)


if __name__ == "__main__":
    main()
