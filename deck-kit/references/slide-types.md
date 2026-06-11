# Slide-type vocabulary

The template (`template/deck.html`) is a working 9-slide reference. Each `<section class="slide">`
is one self-contained, absolutely-positioned block on a 1600×900 stage. To build a new deck, **clone
the template and rewrite the content of each block**, adding/removing/reordering blocks as the outline
needs. Below is the vocabulary — what each block is for and the levers to pull.

## Layout primitives (shared)

- **Stage:** fixed `1600 × 900`. Everything is positioned in px against it; it auto-scales to the
  viewport via a transform, and prints 1:1.
- `img.cut` — a collage cutout. Always `mix-blend-mode:multiply` so its white-pointed background
  melts into `--bg`. **Never wrap a `.cut` image in a `z-index`'d container** — that creates a
  stacking context and breaks the blend.
- `.scrap` — torn-newspaper texture tiles (corners/edges). `.tape` / `.torn` — torn-paper clip-path.
- `.foot` — running footer (deck title + page number). `.plus`, `.dots3`, `.scribble`, `.dotgrid` —
  small editorial accents. The grain overlay is automatic via `.slide::after`.
- Headline scale: `h1` ~104-122px (cover/closing), `h2` ~64px (content titles), `h3` 21px (labels).

## Block types

| # | Type | Purpose | Content levers | Library role |
|---|------|---------|----------------|--------------|
| 1 | **Cover** | Title slide | eyebrow, big `h1` (2-3 lines), accent rule, kicker subtitle | `role:hero` (4:5) |
| 2 | **Agenda / TOC** | Numbered contents | 2-col `.agenda-grid`, 4-8 items (num + title + sub) | `role:edge-strip` (3:4) |
| 3 | **Section divider** | Chapter break | giant `.num` (01..), `h2` section name, kicker, 1-line intro | `role:hero` (4:5) |
| 4 | **About / content + stats** | Prose + metrics | left `.body` paragraph, right `.statcard` (2×2: icon + `.statnum` + `.statlabel`) | `role:figure` (3:4) |
| 5 | **Process / steps** | Linear flow | `.process` row of 3-6 `.step` (colored `.ball` + icon + `h3` + caption), arrows between | accents (brush, hand) |
| 6 | **Cards / initiatives** | 2-4 parallel items | `.col3` grid, each cell = square `.cut` + `h3` + caption | `role:card` (1:1) ×N |
| 7 | **Data feature** | One hero stat block | large square `.cut` feature + `.statcard` 2×2 | `role:feature` (1:1) |
| 8 | **Timeline / roadmap** | Time sequence | `.timeline-wrap` row image + `.tl-year` labels + `.tl-line` dots + `.tl-desc` captions | `role:row` (21:9) |
| 9 | **Closing / thank-you** | Sign-off | `h1`, 1-line message, `.contact` rows (icon + text) | `role:hero` (3:4) |

### Additional content blocks you can compose (not in the base 9, but same primitives)

- **Quote page:** oversized `h2` quote in quotes, small attribution kicker, one tall `.cut` figure
  bleeding off one edge; lots of negative space.
- **Two-column editorial:** two `.body` columns under an `h2`, a `.cut` accent floating across the gutter.
- **Full-bleed statement:** single `h1` centered/left, one large collage off the opposite edge (use the
  closing block, swap content).

## Outline → blocks (default mapping)

1. Cover · 2. Agenda · 3. Section divider (per chapter) · 4-7. Content (pick from about / process /
cards / data / quote / two-column to fit the material) · 8. Timeline (if there's a time dimension) ·
9. Closing. Aim **8-14 slides**; insert a divider before each major chapter.

## Editing rules

- Keep one idea per slide; headlines short and declarative; captions ≤ 2 lines.
- Replace the footer text (`Editorial Collage Template`) with the deck's running title, and renumber
  `NN / TT` on every slide to match the final count (the on-screen counter is automatic; the printed
  footer string is hardcoded per slide — update it).
- Mix monochrome photos with **accent color shapes**; never use corporate clip-art icons (the SVG
  line icons in stat cards / steps are fine — they're hand-weighted, not stock).
