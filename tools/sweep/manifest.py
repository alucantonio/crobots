"""Parameter manifest for the hulk_25 Tier-1 (shot-model) sweep.

Every entry replaces an *anchored literal* in robots/2025/hulk_25.r.  `count` is the
exact number of occurrences a substitution must hit, so a silently-missed pattern is
impossible (substitute() raises).  `render(v)` must reproduce the original text
character-for-character for the current value (golden-tested).

Coordinates in the source (verified against the 219-line file):
  A1  `orng > 425`                       x5  (lines 37,42,47,52,81)  far/near regime
  B1  `((1200 + rng) >> 9)`              x1  (line 110)              lead = dang * (off+rng)>>shift
  B3  `rng * 192 / (192 + orng - rng - (cos`  x1 (line 110)          precise-shot shrink base
  D1  `rng * 145 / (145 + orng - rng))`      x1 (line 178)           fast-shot shrink base
      (both anchored with their unique tail: they share the rng*X/(X+ shape, so a
       bare numeric pattern collides whenever one is set to the other's literal)
"""

ORIGINAL = "robots/2025/hulk_25.r"

# (off, shift) lead-model tuple
CURRENT = {
    "A1": 425,
    "B1": (1200, 9),
    "B3": 192,
    "D1": 145,
}

PARAMS = {
    "A1": {
        "desc": "far/near regime threshold: >A1 -> square patrol + Rompi, <= -> oscillation + 2xSpacca",
        "pattern": r"orng > 425",
        "count": 5,
        "render": lambda v: f"orng > {v}",
        "values": [350, 400, 425, 450, 500],
    },
    "B1": {
        "desc": "lead model: lead_deg = dang * (off + rng) >> shift  (lead mult (off+rng)/2**shift)",
        "pattern": r"\(\(1200 \+ rng\) >> 9\)",
        "count": 1,
        "render": lambda v: f"(({v[0]} + rng) >> {v[1]})",
        "values_off": [960, 1080, 1200, 1320, 1440],
        "values_shift": [8, 9, 10],
    },
    "B3": {
        "desc": "precise-shot range shrink: dist = rng*base/(base + orng-rng - cos>>12)",
        "pattern": r"rng \* 192 / \(192 \+ orng - rng - \(cos",
        "count": 1,
        "render": lambda v: f"rng * {v} / ({v} + orng - rng - (cos",
        "values": [160, 176, 192, 208, 224],
    },
    "D1": {
        "desc": "fast-shot range shrink: dist = rng*base/(base + orng-rng).  "
                "Pattern includes the unique `))` tail so it never collides with B3, "
                "whose line continues with ` - (cos` (both share the rng*X/(X+ shape).",
        "pattern": r"rng \* 145 / \(145 \+ orng - rng\)\)",
        "count": 1,
        "render": lambda v: f"rng * {v} / ({v} + orng - rng))",
        "values": [116, 130, 145, 160, 174],
    },
}

# Coordinate-descent axis order. B1 is 2-D; we descend offset and shift separately.
AXES = [
    ("A1",   "A1",   "values"),
    ("B1o",  "B1",   "values_off"),
    ("B1s",  "B1",   "values_shift"),
    ("B3",   "B3",   "values"),
    ("D1",   "D1",   "values"),
]


def candidate_values(axis, state):
    """List of value options for one axis, anchored on the CURRENT state (B1 = (off,shift))."""
    name, param, key = axis
    if param == "B1":
        cur = state["B1"]
        if key == "values_off":
            return [(o, cur[1]) for o in PARAMS["B1"]["values_off"]]
        return [(cur[0], s) for s in PARAMS["B1"]["values_shift"]]
    return list(PARAMS[param]["values"])
