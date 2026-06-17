#!/usr/bin/env python3
"""Consistency guard: assert every deck carries the same core chrome.

Templates and the example decks must stay in lockstep on the shared feature blocks (navigation,
palette switching, inline editing, the in-browser PDF export, and image swap). When you add a
feature to the templates, this check fails loudly if you forget to port it to the examples, which
is exactly the drift that let the image-swap feature go missing from the examples.

Run from anywhere; exits non-zero on drift so it works as a pre-push or CI check:

  python3 scripts/check-decks.py
"""
import pathlib, sys, subprocess

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
    # the robust, class-agnostic editing implementations (reverting any of these is what
    # let text go non-editable, images non-swappable, or text get covered in edit mode)
    ("robust text edit",      "cn[i].nodeType===3&&cn[i].textContent.trim()"),
    ("robust image wiring",   "querySelectorAll('.slide img').forEach"),
    ("edit layering fix",     "body.editing .slide .imgedit{z-index:auto}"),
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

# Behavioral guard: actually render each deck and confirm editing works (every text leaf
# editable, every image swappable, nothing covering text in edit mode). Static checks above
# only prove the code is present; this proves it behaves. Skips if Chrome is absent or when
# called with --no-render (use it for a fast, browserless run).
if "--no-render" in sys.argv:
    print("render check skipped (--no-render)")
    sys.exit(0)
print("\nrendering each deck to verify edit mode (headless Chrome)...")
rc = subprocess.run([sys.executable, str(ROOT / "scripts" / "check-edit.py")]).returncode
sys.exit(rc)
