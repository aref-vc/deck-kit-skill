#!/usr/bin/env python3
"""Consistency guard: assert every deck carries the same core chrome.

Templates and the example decks must stay in lockstep on the shared feature blocks (navigation,
palette switching, inline editing, the in-browser PDF export, and image swap). When you add a
feature to the templates, this check fails loudly if you forget to port it to the examples, which
is exactly the drift that let the image-swap feature go missing from the examples.

Run from anywhere; exits non-zero on drift so it works as a pre-push or CI check:

  python3 scripts/check-decks.py
"""
import pathlib, sys

ROOT = pathlib.Path(__file__).resolve().parents[1]
DECKS = sorted((ROOT / "templates").glob("*/deck.html")) \
      + sorted((ROOT / "examples").glob("*/*/deck.html"))

# (human label, substring that must appear in every deck.html)
REQUIRED = [
    ("nav",               "function show("),
    ("palette switcher",  "const THEMES"),
    ("inline edit",       "function toggleEdit"),
    ("edit commit",       "function commitEdits"),
    ("pdf export",        "function exportPDF"),
    ("pdf assembler",     "function imagesToPdf"),
    ("export visibility", "body.exporting"),
    ("image swap",        "IMGSWAP_FEATURE"),
]

if not DECKS:
    print("no decks found; run from the repo"); sys.exit(2)

failures = []
for d in DECKS:
    html = d.read_text(encoding="utf-8")
    missing = [label for label, sub in REQUIRED if sub not in html]
    if missing:
        failures.append((d.relative_to(ROOT), missing))

print(f"checked {len(DECKS)} decks against {len(REQUIRED)} required feature blocks")
if failures:
    print("\nDRIFT FOUND — these decks are missing core chrome:")
    for rel, missing in failures:
        print(f"  {rel}: missing {', '.join(missing)}")
    sys.exit(1)
print("OK: every template and example deck has the full core chrome.")
