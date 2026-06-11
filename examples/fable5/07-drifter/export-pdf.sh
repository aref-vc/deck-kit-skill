#!/usr/bin/env bash
# Render deck.html → deck.pdf at exactly 1600×900 per page (16:9), backgrounds on.
# Uses headless Chrome so output is identical regardless of viewer/printer settings.
#
#   ./export-pdf.sh [input.html] [output.pdf]
#
set -euo pipefail
cd "$(dirname "$0")"

IN="${1:-deck.html}"
OUT="${2:-deck.pdf}"
PORT=8941

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
[ -x "$CHROME" ] || CHROME="$(command -v google-chrome || command -v chromium || true)"
[ -n "$CHROME" ] || { echo "Chrome/Chromium not found"; exit 1; }

# Serve locally so relative asset paths resolve (file:// blocks some fetches).
python3 -m http.server "$PORT" >/dev/null 2>&1 &
SRV=$!
trap 'kill $SRV 2>/dev/null || true' EXIT
sleep 1

"$CHROME" --headless=new --disable-gpu --no-pdf-header-footer \
  --print-to-pdf="$OUT" "http://localhost:$PORT/$IN" 2>/dev/null

echo "Wrote $OUT"
