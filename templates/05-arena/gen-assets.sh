#!/usr/bin/env bash
# Arena (05) imagery — motion-blur athletic duotone on dark #0E0E0E.
# Accents: electric yellow #E8FF00, red #E2231A, blue #1E6BFF, green #10B981, orange #FF7A00.
# Generates sequentially (one at a time) to dodge rate limits, then bakes each
# onto the #0E0E0E background so the PDF needs no blend mode.
set -u
cd "$(dirname "$0")"
GEN="$HOME/.claude/skills/gemini-imagegen/scripts/generate_image.py"
BG="#0E0E0E"

bake(){ # name
  local f="assets/$1"
  [ -f "$f" ] || return 0
  magick "$f" -level 0%,88% \( -clone 0 -fill "$BG" -colorize 100 \) -compose multiply -composite -quality 90 "$f"
}
gen(){ # name prompt aspect size
  echo ">> $1"
  python3 "$GEN" "$2" "assets/$1" --aspect "$3" --size "$4" && bake "$1" || echo "   (failed: $1 — fallback covers it)"
}

DUO="High-contrast motion-blur duotone sports photograph, athletes in dynamic motion with long-exposure speed streaks, lit only in electric yellow #E8FF00 and white against a solid near-black #0E0E0E background, deep shadows, grain, kinetic energy. No text, no letters, no logos, no watermark."

gen cover.jpg       "$DUO A footballer mid-sprint breaking past, body blurred with trailing speed streaks, jersey edge catching electric yellow #E8FF00 light, a slash of red #E2231A motion blur behind. Tight low-angle hero shot, athlete on the right side, empty dark space on the left. Solid near-black #0E0E0E background." 3:4 2K
gen about.jpg       "$DUO A single footballer standing tall and still in a dark stadium tunnel, half lit in cold blue #1E6BFF rim light, faint crowd lights bokeh behind. Quiet powerful portrait, vertical, lots of black around the figure. Solid near-black #0E0E0E background." 3:4 2K
gen index-strip.jpg "$DUO Vertical stack along the right edge of three motion fragments: a blurred ball strike, sprinting legs with speed streaks, and a goalkeeper's dive, each lit in blue #1E6BFF and yellow #E8FF00. Vertical strip, empty dark left side. Solid near-black #0E0E0E background." 3:4 2K
gen team-row.jpg    "$DUO A horizontal row of SIX footballers in identical fighting stances, evenly spaced on one baseline, each frozen with slight motion blur, alternating rim lights in yellow #E8FF00, red #E2231A, blue #1E6BFF, green #10B981, orange #FF7A00 and white. Even gaps between figures. Solid near-black #0E0E0E background filling the gaps." 21:9 2K
gen pillars-row.jpg "$DUO A horizontal row of FIVE explosive athletic actions evenly spaced on one baseline: a sprint start, a ball strike, a header leap, a slide tackle, and a goal celebration, each a motion-blurred silhouette lit in yellow #E8FF00, red #E2231A, blue #1E6BFF, green #10B981, orange #FF7A00. Even gaps. Solid near-black #0E0E0E background filling the gaps." 21:9 2K
gen roadmap-row.jpg "$DUO A horizontal row of SIX motion-blur sports moments evenly spaced on one baseline: kick-off whistle, a packed terrace, a derby clash, a trophy lift, an away-day coach, and a final-whistle roar, each a small blurred vignette lit in yellow #E8FF00 and blue #1E6BFF. Even gaps. Solid near-black #0E0E0E background filling the gaps." 21:9 2K
gen results.jpg     "$DUO A footballer striking a powerful shot, the ball and leg streaked with long-exposure blur, lit in electric yellow #E8FF00 and red #E2231A, ascending motion trails behind suggesting rising bars. Square crop, figure centred. Solid near-black #0E0E0E background." 1:1 2K
gen closing.jpg     "$DUO A footballer with arms raised in a triumphant goal celebration, head back, motion-blurred crowd and flares behind in yellow #E8FF00 and orange #FF7A00 light. Vertical heroic shot, figure on the right, dark space on the left. Solid near-black #0E0E0E background." 3:4 2K
gen manifesto.jpg   "$DUO A clenched footballer's fist and forearm raised in defiance, sharp against streaked yellow #E8FF00 motion light, square crop, lots of black around it. Solid near-black #0E0E0E background." 1:1 1K
gen landscape.jpg   "$DUO A wide motion-blur shot of two footballers contesting a ball at speed, bodies split by a streak of light, left side lit red #E2231A and right side lit blue #1E6BFF, horizontal. Solid near-black #0E0E0E background." 4:3 1K
gen card-1.jpg      "$DUO A close motion-blur of a footballer pulling on a jersey collar, lit in electric yellow #E8FF00, square crop. Solid near-black #0E0E0E background." 1:1 1K
gen card-2.jpg      "$DUO A wide empty floodlit stadium stand at night with light beams and faint blurred figures, lit cold blue #1E6BFF, square crop. Solid near-black #0E0E0E background." 1:1 1K
gen card-3.jpg      "$DUO A close motion-blur of a phone filming a player, screen glow in green #10B981 against the dark, square crop. Solid near-black #0E0E0E background." 1:1 1K
gen quote.jpg       "$DUO A head coach in profile on the touchline shouting instructions, jaw set, rim lit in red #E2231A with blurred dugout lights behind, vertical, figure facing left, dark space around. Solid near-black #0E0E0E background." 3:4 2K

echo "done."
