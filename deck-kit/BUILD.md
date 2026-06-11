# Editorial Collage Deck — Build Spec

> Status: **standalone build**, not yet installed as a Claude Code skill. This file is written so it
> can later be promoted to a `SKILL.md` (add the YAML frontmatter in the last section and move the
> folder to `~/.claude/skills/editorial-deck/`). For now, run the pipeline manually in a session.

Turn **any text input** into a 16:9 editorial-collage HTML slide deck: classical sculpture, vintage
photography, torn newsprint, planets, and flat accent-color paper shapes on light paper. Output is a
self-contained HTML deck with live palette themes, inline editing, and pixel-perfect PDF export.

## Inputs (any of)

- A **topic / trigger** ("make a deck about X") → light web research.
- A **document** — PDF, doc, markdown, etc. → extract & condense.
- A **repo or codebase** → summarize what it is / how it works.
- **Chat / project notes** already in the session → synthesize.

## Pipeline

### 1 · Ingest & synthesize
- Topic → run a **few web searches** (lightweight, not the deep-research harness) and synthesize the
  findings. Cite sources in a closing/notes slide if the user wants receipts.
- Document/repo → read it, pull the spine: thesis, 3-6 supporting sections, key numbers, a forward look.
- Produce a tight **content brief**: working title, subtitle, 1-line thesis, list of sections, any
  stats, a closing CTA.

### 2 · Outline → slide plan
- Map the brief onto the **block vocabulary** in `references/slide-types.md`.
- Default arc: Cover → Agenda → (Section divider → 1-3 content blocks) per chapter → Timeline (if
  there's a time dimension) → Closing. Target **8-14 slides**; one idea per slide.
- Choose content blocks to fit the material: prose+stats, process/steps, cards, data feature, quote,
  two-column. Don't force a block that the content doesn't support.

### 3 · Theme
- Pick a built-in theme from `references/palettes.md` (default **newsroom**), or derive one from the
  brand/topic. Set the `body.theme-*` class. User can switch live later from the toolbar.

### 4 · Scaffold + assemble
- `scripts/new-deck.sh <out-dir>` → working copy of template + library + exporter.
- Clone/rewrite each `<section class="slide">` in `deck.html`: replace headlines, captions, stats,
  agenda items, footer running-title, and the `NN / TT` page numbers. Add/remove/reorder blocks.
- Keep the layout primitives intact (stage 1600×900, `img.cut` multiply, no z-index on cut wrappers).

### 5 · Imagery (hybrid)
- **Reuse** `library/` for inner cards, timeline, accents — match by `motif`/`role`/`aspect` in
  `library/manifest.json`.
- **Generate fresh** only the topic-carrying heroes (cover, each section divider, closing) per
  `references/image-prompts.md`.
- Match generated accent shapes to the chosen theme hex if you want palette-true imagery.
- **Light vs dark blend (critical):** light themes white-point and bake the multiply onto the bg; dark
  themes (bg ≈ #0A–#1A) must NOT bake — multiplying onto near-black crushes the image to black. Generate
  dark-background imagery and place it directly with only a black-point lift. See `references/image-prompts.md`.

### 6 · Verify
- Serve (`python3 -m http.server`) and screenshot a few slides in a browser; check blends, overflow,
  and that page numbers/titles are consistent. Fix positioning in px against the 1600×900 stage.

### 7 · Export (optional)
- `./export-pdf.sh` → `deck.pdf`, one exact 1600×900 page per slide, backgrounds on, no layout drift.

## Built-in deck features (already in the template)

- **Navigation:** ← / → / space / Home / End / on-screen ‹ › / `#n` URL hash.
- **Palette switcher:** toolbar dropdown — Newsroom / Riso / Noir / Botanic (live).
- **Inline editing:** toolbar **Edit** (or press `E`) makes text `contenteditable`; **Save** (or `⌘S`)
  writes the HTML back to disk via the File System Access API, falling back to a download.
- **PDF:** toolbar **PDF** (browser print) or `export-pdf.sh` (headless Chrome, exact geometry).
- Auto-scales to any viewport; grain + paper texture baked in.

## Kit layout

```
deck-kit/
  BUILD.md                 ← this file (→ future SKILL.md)
  template/deck.html       ← working 9-slide reference to clone
  template/export-pdf.sh
  library/*.jpg            ← 17 reusable collage assets
  library/manifest.json    ← motif / aspect / baked-colors / use per asset
  references/palettes.md   ← themes + how to add / derive
  references/slide-types.md← block vocabulary + outline mapping
  references/image-prompts.md ← Gemini recipes for bespoke heroes
  scripts/new-deck.sh      ← scaffold an output deck from the kit
```

## To promote to a skill later

1. Prepend YAML frontmatter to this file as `SKILL.md`:
   ```yaml
   ---
   name: editorial-deck
   description: Generate an editorial-collage HTML slide deck (16:9) from any input — topic, document,
     repo, or chat. Mixed-media collage: classical sculpture, vintage photography, torn newsprint,
     accent-color paper shapes. Outputs self-contained HTML with palette themes, inline editing, and
     pixel-perfect PDF export. Use for presentations/pitch decks in this collage/editorial style.
   ---
   ```
2. Move `deck-kit/` → `~/.claude/skills/editorial-deck/` (paths in scripts are already absolute or
   relative to the kit root).
3. Test with `/editorial-deck <topic>`.
