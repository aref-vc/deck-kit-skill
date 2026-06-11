#!/usr/bin/env bash
# Generate the 07-drifter kraft ephemera collage batch (hobo / earthy palette:
# terracotta #C2683E / rust #A8542F / mustard #C9942F / olive #7C7A4A / kraft brown #9C7A4E,
# background kraft #EAE0CF). Each image is white-pointed (-level 0%,88%) then baked onto --bg
# via multiply so the PDF needs no blend mode.
set -uo pipefail
cd "$(dirname "$0")"
GEN=$HOME/.claude/skills/gemini-imagegen/scripts/generate_image.py
BG="#EAE0CF"
gen(){ # name prompt aspect size
  "$GEN" "$2" "assets/$1" --aspect "$3" --size "$4" >/dev/null 2>&1 \
    && magick "assets/$1" -level 0%,88% \( -clone 0 -fill "$BG" -colorize 100 \) -compose multiply -composite -quality 90 "assets/$1" \
    && echo "ok  $1" || echo "FAIL $1"
}

gen cover.jpg "Kraft-paper ephemera collage on plain kraft-brown paper hex #EAE0CF. A layered travel scrapbook: a vintage sepia-toned photograph of a lone hiker on an open road, taped down with strips of masking tape, surrounded by a worn postage stamp, a round purple postmark cancellation ring, a frayed length of jute twine, and a torn ticket stub. Flat torn paper shapes in terracotta #C2683E and rust #A8542F behind. Aged paper grain, coffee stains, hand-stitched thread, soft shadows. Plain kraft paper background hex #EAE0CF filling all empty space. No readable text, no letters, no watermark." 3:4 2K

gen about.jpg "Kraft-paper ephemera collage on plain kraft-brown paper hex #EAE0CF. A weathered open field journal: a sepia photograph of a workshop bench with hand tools, mounted with photo corners, beside a wax seal, a pressed leaf, a frayed luggage tag tied with twine, and a torn mustard #C9942F paper strip. Aged paper grain, faint coffee ring, stitched thread border. Plain kraft paper background hex #EAE0CF filling all empty space. No readable text, no letters, no watermark." 3:4 2K

gen index-strip.jpg "Kraft-paper ephemera collage arranged as a vertical strip along the right edge on plain kraft paper hex #EAE0CF: stacked top to bottom a torn vintage train ticket, a round terracotta #C2683E postmark ring, a worn postage stamp, a coil of jute twine, and a small sepia photograph of a winding mountain road taped with masking tape. Elements stacked vertically along the right. Aged paper grain, stitched thread. Plain kraft paper background hex #EAE0CF filling the empty left side. No readable text, no letters, no watermark." 3:4 2K

gen team-row.jpg "Kraft-paper ephemera collage on plain kraft paper hex #EAE0CF: a horizontal row of SIX different small sepia-toned vintage portrait photographs, varied faces and angles, each mounted on its own torn paper card with photo corners and a strip of masking tape, the cards in alternating flat colours terracotta #C2683E, rust #A8542F, mustard #C9942F, olive #7C7A4A, kraft brown #9C7A4E and grey, arranged evenly spaced in a row on a single baseline, slightly staggered heights, small postage stamps and twine accents. Aged paper grain, stitched thread. Plain kraft paper background hex #EAE0CF filling all gaps. No readable text, no letters, no watermark." 21:9 2K

gen pillars-row.jpg "Kraft-paper ephemera collage on plain kraft paper hex #EAE0CF: a horizontal row of FIVE sepia-toned vintage travel objects evenly spaced on a single baseline: a brass compass, a folded paper map, a worn leather boot, a tin enamel cup, and a rolled bedroll; each mounted over its own torn paper shape in alternating colours terracotta #C2683E, rust #A8542F, mustard #C9942F, olive #7C7A4A, kraft brown #9C7A4E, with twine and a postmark ring accent. Aged paper grain, stitched thread, photo corners. Plain kraft paper background hex #EAE0CF filling all gaps. No readable text, no letters, no watermark." 21:9 2K

gen roadmap-row.jpg "Kraft-paper ephemera collage on plain kraft paper hex #EAE0CF: a horizontal row of SIX small sepia-toned motifs evenly spaced on a single baseline: a sprouting seed, a trail marker post, a brass compass, a wooden footbridge, a campfire, and a mountain summit cairn; each over a small torn paper circle in alternating colours terracotta #C2683E, rust #A8542F, mustard #C9942F, olive #7C7A4A, kraft brown #9C7A4E, grey, with a dashed route-map line connecting them and small postmark stamps. Aged paper grain, stitched thread. Plain kraft paper background hex #EAE0CF filling all gaps. No readable text, no letters, no watermark." 21:9 2K

gen results.jpg "Kraft-paper ephemera collage on plain kraft paper hex #EAE0CF: a sepia photograph of a stack of weathered travel notebooks and a brass compass taped down, with a collaged set of ascending torn-paper bars rising behind like an abstract chart in terracotta #C2683E and mustard #C9942F, a round rust #A8542F postmark ring, jute twine, and a worn postage stamp. Aged paper grain, stitched thread, photo corners. Plain kraft paper background hex #EAE0CF filling all empty space. No readable text, no letters, no numbers, no watermark." 1:1 2K

gen closing.jpg "Kraft-paper ephemera collage on plain kraft paper hex #EAE0CF: a sepia photograph of a hand waving from an open train window taped with masking tape, surrounded by a flat terracotta #C2683E torn paper shape, a rust #A8542F postmark ring, a pressed flower, a frayed luggage tag on twine, and a worn postage stamp. Aged paper grain, coffee stain, stitched thread. Plain kraft paper background hex #EAE0CF filling all empty space. No readable text, no letters, no watermark." 3:4 2K

gen manifesto.jpg "Kraft-paper ephemera collage on plain kraft paper hex #EAE0CF: a single sepia photograph of an open hand holding a folded paper map, taped with masking tape, over a flat terracotta #C2683E torn arc, with a coil of jute twine and a worn postage stamp. Aged paper grain, stitched thread. Plain kraft paper background hex #EAE0CF filling all empty space. No readable text, no letters, no watermark." 1:1 2K

gen landscape.jpg "Kraft-paper ephemera collage on plain kraft paper hex #EAE0CF: a sepia photograph of a wide valley with a winding trail, torn down the middle by a ragged seam, the left half over a flat terracotta #C2683E shape and the right half over a flat olive #7C7A4A shape, a folded route map fragment, twine, and a postmark ring in a corner. Aged paper grain, stitched thread. Plain kraft paper background hex #EAE0CF filling all empty space. No readable text, no letters, no watermark." 4:3 2K

gen card-1.jpg "Single kraft-paper ephemera collage cutout on plain kraft paper hex #EAE0CF: a sepia photograph of a brass compass and a folded paper map, taped with masking tape over a flat terracotta #C2683E torn paper square, with a small worn postage stamp. Aged paper grain, stitched thread, photo corners. Plain kraft paper background hex #EAE0CF filling all empty space. No readable text, no letters, no watermark." 1:1 2K

gen card-2.jpg "Single kraft-paper ephemera collage cutout on plain kraft paper hex #EAE0CF: a sepia photograph of a worn leather satchel and a tin cup, taped with masking tape over a flat rust #A8542F torn paper square, with a coil of jute twine. Aged paper grain, stitched thread, photo corners. Plain kraft paper background hex #EAE0CF filling all empty space. No readable text, no letters, no watermark." 1:1 2K

gen card-3.jpg "Single kraft-paper ephemera collage cutout on plain kraft paper hex #EAE0CF: a sepia photograph of a pressed wildflower and a sprig of dried grass, mounted with photo corners over a flat olive #7C7A4A torn paper square, with a small postmark ring. Aged paper grain, stitched thread. Plain kraft paper background hex #EAE0CF filling all empty space. No readable text, no letters, no watermark." 1:1 2K

gen quote.jpg "Kraft-paper ephemera collage on plain kraft paper hex #EAE0CF: a sepia photograph of a lone traveller seated on a rock looking at a view, taped over a large flat terracotta #C2683E torn paper shape, with big hand-stitched thread quotation marks, a postmark ring, and a worn postage stamp. Aged paper grain, jute twine, coffee stain. Plain kraft paper background hex #EAE0CF filling all empty space. No readable text, no letters, no watermark." 3:4 2K

gen texture-scraps.jpg "A few scattered torn kraft-paper scraps, worn postage stamps, a round postmark ring, and short lengths of frayed jute twine, warm sepia and brown tones, ragged torn edges, aged paper grain and coffee stains, lying flat and well separated on a plain kraft-brown paper background hex #EAE0CF, large empty space between scraps, top-down flat view. No readable words, no watermark." 16:9 2K

echo "=== 07-drifter asset batch complete ==="
