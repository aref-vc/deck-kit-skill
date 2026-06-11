#!/bin/bash
set -u
cd "/Users/aref/Dev/04_Design Exploration/Decks Design/deck-kit/templates/04-studio"
GEN="/Users/aref/.claude/skills/gemini-imagegen/scripts/generate_image.py"
BG="#F5F4F2"
STYLE="Bold high-contrast duotone photograph, two-tone posterized, heavy grain, editorial creative-studio mood. Two-color treatment only: deep near-black shadows and a light warm off-white background hex #F5F4F2 in the highlights. A single saturated accent tint pushes through. Flat, graphic, confident negative space. No text, no logos, no watermarks."

gen () {
  local name="$1" aspect="$2" accent="$3" subject="$4"
  local prompt="$STYLE Accent color this image toward $accent. Subject: $subject. Background must read as off-white hex #F5F4F2 so it sits on a creative-studio deck."
  echo ">>> $name ($aspect, $accent)"
  python3 "$GEN" "$prompt" "assets/$name" --aspect "$aspect" --size 2K 2>&1 | tail -2
  if [ -f "assets/$name" ]; then
    magick "assets/$name" -level 0%,88% \( -clone 0 -fill "$BG" -colorize 100 \) -compose multiply -composite -quality 90 "assets/$name"
    echo "    baked $name"
  else
    echo "    MISSING $name"
  fi
}

gen cover.jpg        "3:4"  "coral #FF5A3C"        "a sculptural close-up of a designer's hands shaping clay or paper, dramatic side light, bold and tactile"
gen manifesto.jpg    "1:1"  "acid lime #C8FF3D"    "a single bold paint roller stroke across paper, raw and graphic"
gen index-strip.jpg  "3:4"  "electric blue #1E6BFF" "a tall stack of design proofs and printed sheets seen edge-on, strong vertical rhythm"
gen about.jpg        "3:4"  "coral #FF5A3C"        "a studio portrait of a creative person looking off-frame, strong jaw light, half in shadow"
gen landscape.jpg    "4:3"  "acid lime #C8FF3D"    "an aerial view of a cluttered studio worktable with tools, scattered swatches and sketches"
gen pillars-row.jpg  "21:9" "electric blue #1E6BFF" "a horizontal row of five abstract sculptural objects on plinths, evenly spaced, museum lighting"
gen card-1.jpg       "1:1"  "coral #FF5A3C"        "a macro shot of a pencil tip on paper mid-stroke"
gen card-2.jpg       "1:1"  "electric blue #1E6BFF" "a macro shot of a hand pulling a screen-print squeegee"
gen card-3.jpg       "1:1"  "acid lime #C8FF3D"    "a macro shot of glossy brand collateral fanned out"
gen team-row.jpg     "21:9" "cool grey #8A8F98"    "a horizontal row of six diverse studio people in candid poses, even spacing, plain backdrop"
gen results.jpg      "1:1"  "coral #FF5A3C"        "a bold oversized printed number on a poster pinned to a studio wall"
gen roadmap-row.jpg  "21:9" "electric blue #1E6BFF" "a horizontal row of six milestone markers, like printed road signs receding in space"
gen quote.jpg        "3:4"  "acid lime #C8FF3D"    "a thoughtful creative director leaning back, arms crossed, strong rim light"
gen closing.jpg      "3:4"  "coral #FF5A3C"        "an open studio doorway with light pouring in, inviting, graphic silhouette"
echo "ALL DONE"
