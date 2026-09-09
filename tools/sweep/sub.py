"""Anchored count-verified substitution of hulk_25 hyperparameters.

substitute(src, values) -> text
  For each parameter present in `values`, replaces every occurrence of its anchored
  pattern with render(value); raises if the hit count != expected.  Parameters not in
  `values` are left untouched.  substitute(src, {}) == src (golden-tested).
"""
import re

from manifest import PARAMS


def substitute(src, values):
    out = src
    for name, val in values.items():
        p = PARAMS[name]
        new = p["render"](val)
        out, n = re.subn(p["pattern"], new, out)
        if n != p["count"]:
            raise RuntimeError(
                f"substitute({name!r}): pattern hit {n}x, expected {p['count']} — "
                f"source changed or pattern stale; aborting"
            )
    return out
