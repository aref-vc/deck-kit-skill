#!/usr/bin/env bash
# Regenerate Arena imagery as proper dark duotones for the dark theme (#0E0E0E).
# IMPORTANT: do NOT multiply-bake onto the dark bg (that crushes images to black).
# Place directly, with only a gentle black-point lift so shadows merge into #0E0E0E.
set -uo pipefail
cd "$(dirname "$0")"
GEN=/Users/aref/.claude/skills/gemini-imagegen/scripts/generate_image.py
gen(){ # name prompt aspect
  "$GEN" "$2 High-contrast black and white sports photograph, dramatic low-key lighting on a near-black #0E0E0E background, a single electric-yellow (#E8FF00) rim light accent, motion energy, fine film grain, editorial sports magazine look. No text, no letters, no watermark." "assets/$1" --aspect "$3" --size 2K >/dev/null 2>&1 \
    && magick "assets/$1" -level 5%,100% -quality 90 "assets/$1" \
    && echo "ok  $1" || echo "FAIL $1"
}

gen cover.jpg        "A footballer leaping mid-air to strike the ball, frozen at the peak of the jump, floodlights behind." 3:4 &
gen about.jpg        "A lone athlete walking out of a stadium tunnel toward the bright floodlit pitch, seen from behind." 3:4 &
gen index-strip.jpg  "A tall vertical composition of stadium floodlight towers glowing against a black night sky, a player silhouette below." 3:4 &
gen closing.jpg      "A footballer with arms raised in victory under floodlights, breath visible in cold air." 3:4 &
gen quote.jpg        "A close portrait of an athlete in shadow, half the face lit by a hard electric rim light, intense expression." 3:4 &
gen landscape.jpg    "A wide night stadium, full floodlit pitch from a high angle, empty stands in shadow." 4:3 &
gen results.jpg      "A packed stadium crowd at night, a sea of fans, scoreboard glow, motion blur." 1:1 &
wait
gen manifesto.jpg    "A football boot striking a ball, extreme close-up, grass and spray frozen in motion." 1:1 &
gen card-1.jpg       "A single football on the penalty spot, hard side light." 1:1 &
gen card-2.jpg       "A polished championship trophy, dramatic single light, deep shadow." 1:1 &
gen card-3.jpg       "A vintage stopwatch held in a hand, hard light, deep black background." 1:1 &
gen team-row.jpg     "A horizontal row of SIX athletes standing shoulder to shoulder in a team lineup, full body, evenly spaced on a near-black background." 21:9 &
gen pillars-row.jpg  "A horizontal row of FIVE separate action sports shots evenly spaced: a sprint start, a high jump, a powerful kick, a sliding tackle, a goal celebration." 21:9 &
gen roadmap-row.jpg  "A horizontal row of SIX small sports objects evenly spaced on a near-black background: a whistle, a football boot, a ball, a trophy, a stadium, a victory flag." 21:9 &
wait
echo "=== arena asset regen complete ==="