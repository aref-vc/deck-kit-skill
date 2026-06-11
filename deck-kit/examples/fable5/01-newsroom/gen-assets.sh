#!/usr/bin/env bash
# Generate the deck-02 collage batch (new visual language, warm-bone palette:
# burnt-orange #E85D2A / cobalt #2A3D8F / ochre #E0A22E / sage #9DAE77 / blush #E0A083,
# background #ECE8E1). Each image is white-pointed (-level 0%,88%) to blend via multiply.
set -uo pipefail
cd "$(dirname "$0")"
GEN=/Users/aref/.claude/skills/gemini-imagegen/scripts/generate_image.py
BG="#ECE8E1"
gen(){ # name prompt aspect size
  "$GEN" "$2" "assets/$1" --aspect "$3" --size "$4" >/dev/null 2>&1 \
    && magick "assets/$1" -level 0%,88% -quality 88 "assets/$1" \
    && echo "ok  $1" || echo "FAIL $1"
}

gen cover.jpg "Editorial avant-garde mixed-media collage cutout: monochrome black-and-white photograph of a classical marble bust of the goddess Athena wearing a crested helmet, three-quarter view facing right, the back of the head dissolving into a large halftone black-and-white planet sphere. Behind it large flat burnt-orange (#E85D2A) concentric ring arcs and a flat cobalt-blue (#2A3D8F) rectangle; small solid black geometric triangles scattered; torn vintage newspaper fragments at the base. Torn paper edges, newsprint texture, paper grain, halftone analog imperfections. Plain warm light grey paper background hex #ECE8E1 filling all empty space. No text, no letters, no watermark." 3:4 2K &

gen about.jpg "Editorial avant-garde mixed-media collage cutout: monochrome black-and-white photograph of the classical Winged Victory of Samothrace marble statue, headless winged Nike with flowing carved drapery, layered over a flat cobalt-blue (#2A3D8F) torn paper rectangle and a flat ochre (#E0A22E) torn square, with crumpled monochrome newspaper scraps around its base and a thin hand-drawn black ink scribble arc. Torn paper edges, newsprint texture, paper grain, halftone analog imperfections. Plain warm light grey paper background hex #ECE8E1 filling all empty space. No text, no letters, no watermark." 3:4 2K &

gen index-strip.jpg "Editorial avant-garde mixed-media collage arranged as a vertical strip along the right edge: a torn vertical strip of vintage newspaper at the top, below it a monochrome black-and-white close-up of a classical marble statue's eye, then a flat burnt-orange (#E85D2A) halftone circle, then a monochrome black-and-white classical marble sculpture hand holding a brass compass. Elements stacked vertically along the right. Torn paper edges, newsprint texture, paper grain, analog imperfections. Plain warm light grey paper background hex #ECE8E1 filling the empty left side. No readable text, no letters, no watermark." 3:4 2K &

gen team-row.jpg "Editorial avant-garde mixed-media collage: a horizontal gallery row of SIX different monochrome black-and-white classical marble portrait busts, varied Greek and Roman heads with different faces and angles, each bust cut out and placed inside its own torn rectangular paper card, the cards in alternating flat colours burnt-orange (#E85D2A), cobalt-blue (#2A3D8F), ochre (#E0A22E), sage-green (#9DAE77), blush (#E0A083) and grey, arranged in an evenly spaced row with equal gaps on a single baseline, slightly staggered heights. Torn paper edges, newsprint texture, paper grain, halftone analog imperfections. Plain warm light grey paper background hex #ECE8E1 filling all empty space between cards. No text, no letters, no watermark." 21:9 2K &

gen pillars-row.jpg "Editorial avant-garde mixed-media collage: a horizontal row of FIVE monochrome black-and-white vintage objects, evenly spaced with equal gaps on a single baseline: a brass compass, an hourglass, an antique key, a lighthouse, and a ship's anchor; each object placed over its own flat torn paper shape in alternating colours burnt-orange (#E85D2A), cobalt-blue (#2A3D8F), ochre (#E0A22E), sage-green (#9DAE77), blush (#E0A083). Torn paper edges, newsprint texture, paper grain, halftone analog imperfections. Plain warm light grey paper background hex #ECE8E1 filling all empty space between objects. No text, no letters, no watermark." 21:9 2K &

gen roadmap-row.jpg "Editorial avant-garde mixed-media collage: a horizontal row of SIX small monochrome black-and-white motifs, evenly spaced with equal gaps on a single baseline: a sprouting seed, a young potted plant, a brass compass, a stone arch bridge, a rocket, and a mountain summit with a flag; each over a small flat torn paper circle in alternating colours burnt-orange (#E85D2A), cobalt-blue (#2A3D8F), ochre (#E0A22E), sage-green (#9DAE77), blush (#E0A083), grey. Torn paper edges, newsprint texture, paper grain, halftone imperfections. Plain warm light grey paper background hex #ECE8E1 filling all empty space between them. No text, no letters, no watermark." 21:9 2K &

gen results.jpg "Editorial avant-garde mixed-media collage cutout: monochrome black-and-white photograph of a classical marble bust in profile, with a collaged halftone black-and-white set of ascending geometric bars rising behind it like an abstract chart, a flat burnt-orange (#E85D2A) torn rectangle and a cobalt-blue (#2A3D8F) circle, torn vintage newspaper fragments. Torn paper edges, newsprint texture, paper grain, halftone analog imperfections. Plain warm light grey paper background hex #ECE8E1 filling all empty space. No text, no letters, no numbers, no watermark." 1:1 2K &

gen closing.jpg "Editorial avant-garde mixed-media collage cutout: monochrome black-and-white photograph of a heroic classical marble statue with one arm raised in triumph, surrounded by a collaged halftone constellation of stars and a thin hand-drawn black orbital scribble, layered over a large flat burnt-orange (#E85D2A) torn paper shape and a cobalt-blue (#2A3D8F) rectangle, with a sprig of laurel and torn newspaper scraps. Torn paper edges, newsprint texture, paper grain, halftone analog imperfections. Plain warm light grey paper background hex #ECE8E1 filling all empty space. No text, no letters, no watermark." 3:4 2K &
wait

gen manifesto.jpg "Editorial avant-garde mixed-media collage cutout: a single monochrome black-and-white classical marble sculpture hand reaching upward holding a small halftone black-and-white sun, with a flat burnt-orange (#E85D2A) torn arc behind and a thin hand-drawn black ink scribble. Torn paper edges at the wrist, newsprint texture, paper grain, halftone imperfections. Plain warm light grey paper background hex #ECE8E1 filling all empty space. No text, no letters, no watermark." 1:1 1K &

gen landscape.jpg "Editorial avant-garde mixed-media collage cutout: a monochrome black-and-white classical marble bust split down the middle by a torn vertical seam, the left half over a flat burnt-orange (#E85D2A) shape and the right half over a flat cobalt-blue (#2A3D8F) shape, with thin black geometric grid lines and a small monochrome halftone globe in a corner. Torn paper edges, newsprint texture, paper grain, halftone analog imperfections. Plain warm light grey paper background hex #ECE8E1 filling all empty space. No text, no letters, no watermark." 4:3 1K &

gen card-1.jpg "Single editorial collage cutout: monochrome black-and-white classical marble sculpture hand holding a quill pen as if writing, over a flat burnt-orange (#E85D2A) torn paper square. Torn paper edges, newsprint texture, paper grain, halftone imperfections. Plain warm light grey paper background hex #ECE8E1 filling all empty space. No text, no letters, no watermark." 1:1 1K &

gen card-2.jpg "Single editorial collage cutout: monochrome black-and-white antique brass telescope on a stand, over a flat cobalt-blue (#2A3D8F) torn paper square. Torn paper edges, newsprint texture, paper grain, halftone imperfections. Plain warm light grey paper background hex #ECE8E1 filling all empty space. No text, no letters, no watermark." 1:1 1K &

gen card-3.jpg "Single editorial collage cutout: monochrome black-and-white laurel wreath and olive branch, over a flat sage-green (#9DAE77) torn paper square. Torn paper edges, newsprint texture, paper grain, halftone imperfections. Plain warm light grey paper background hex #ECE8E1 filling all empty space. No text, no letters, no watermark." 1:1 1K &

gen quote.jpg "Editorial avant-garde mixed-media collage cutout: monochrome black-and-white photograph of a classical marble bust in profile facing left, layered over a large flat burnt-orange (#E85D2A) torn paper shape, with big hand-drawn black ink quotation-mark scribbles and torn vintage newspaper fragments. Torn paper edges, newsprint texture, paper grain, halftone analog imperfections. Plain warm light grey paper background hex #ECE8E1 filling all empty space. No readable text, no letters, no watermark." 3:4 2K &

gen texture-scraps.jpg "A few scattered torn vintage newspaper scraps with blurred unreadable columns of tiny print, warm sepia and grey tones, ragged torn edges, newsprint texture and paper grain, lying flat and well separated on a plain warm light grey paper background hex #ECE8E1, large empty space between scraps, top-down flat view. No readable words, no watermark." 16:9 1K &

gen ink-arc.jpg "A single expressive black ink brush sweep forming a rough circular arc, dry-brush bristle texture with splatter, on a plain warm light grey paper background hex #ECE8E1. Minimal, high contrast, analog texture. No text, no letters, no watermark." 1:1 1K &
wait
echo "=== deck-02 asset batch complete ==="
