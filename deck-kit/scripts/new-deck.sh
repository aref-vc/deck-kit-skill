#!/usr/bin/env bash
# Scaffold a new deck by copying a template folder.
#
#   ./new-deck.sh <output-dir> [template-id]
#
# template-id defaults to 01-newsroom. See deck-kit/templates/ for the full set.
set -euo pipefail
KIT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="${1:?usage: new-deck.sh <output-dir> [template-id, default 01-newsroom]}"
TPL="${2:-01-newsroom}"
SRC="$KIT/templates/$TPL"

[ -d "$SRC" ] || { echo "no such template: $TPL"; echo "available:"; ls -1 "$KIT/templates" | grep -E '^[0-9]'; exit 1; }

cp -r "$SRC" "$OUT"
rm -f "$OUT/deck-standalone.html"

echo "Scaffolded $OUT from template $TPL"
echo "  1) edit content in $OUT/deck.html"
echo "  2) build the single-file version:  (cd \"$OUT\" && python3 build-standalone.py)"
