---
name: deck-kit
description: Build a polished, self-contained 16:9 HTML slide deck from any input (a topic, a document, a repo, a chat, or a brief) in one of ten editorial styles: editorial collage, Mondrian, impressionist, creative-agency, sports, luxury, earthy kraft, data/charts, dark terminal, or futuristic wireframe. Every deck has live palette switching, inline text and image editing, and one-click pixel-accurate PDF export with fonts embedded. Use this whenever the user wants a presentation, slide deck, pitch deck, report deck, capabilities deck, sales deck, or asks to "turn this into slides" or "make a deck", even if they do not name a style, and especially when they want a specific visual look or a report rendered as slides.
---

# Deck Kit

Turn any input into a finished 16:9 slide deck that is a single self-contained HTML file: open it in
any browser, edit it in place, and export a pixel-accurate PDF. Ten visual styles share one 12-slide
backbone, so you pick a look and pour content in.

Each style lives in `templates/<id>-<name>/` as a complete, working deck you copy and re-content. You
do not build a deck from scratch; you reskin a template. That is what keeps output consistent and fast.

## Inputs

Work from whatever the user gives you:
- A **topic** ("make a deck about X") then do a few light web searches and synthesize.
- A **document** (PDF, doc, markdown): read it and pull the spine (thesis, sections, numbers, outlook).
- A **repo or codebase**: summarize what it is and how it works.
- **Chat or project notes** already in the session: synthesize directly.

## Pick a template

Choose by the user's stated style, or by what fits the material. The full registry with palettes,
fonts, and best-for is in [TEMPLATES.md](TEMPLATES.md). Quick guide:

| id | style | reach for it when |
|----|-------|-------------------|
| `01-newsroom` | editorial collage (sculpture, newsprint) | brand story, manifesto, research dossier |
| `02-grid` | Mondrian / De Stijl (color planes, black rules) | frameworks, design systems, modular breakdowns |
| `03-plein-air` | impressionist (painterly, pastel) | culture, vision, narrative |
| `04-studio` | creative agency (bold duotone, big type) | pitches, portfolios, proposals |
| `05-arena` | sports (dark, motion duotone) | sponsorship, sports business, performance |
| `06-maison` | luxury (Didone, gold, deep negative space) | investor/board, premium brand |
| `07-drifter` | earthy kraft (stamps, woodtype) | travel, craft, sustainability, field reports |
| `08-ledger` | data (Tufte-clean charts, one signal color) | market research, financial, KPI |
| `09-terminal` | dark CRT console (monospace, schematics) | repos, architecture, AI/agent systems |
| `10-vanguard` | futuristic (wireframe, HUD) | deep-tech, robotics, R&D |

`02`, `08`, `09`, `10` draw their visuals as inline SVG and need no image generation. The other six use
photographic or collage imagery (see Imagery below).

## Build a deck

1. **Synthesize a brief.** Distill the input into a working title, a one-line thesis, the sections, any
   real numbers, and a closing. Keep numbers real and cite sources; never invent figures.

2. **Scaffold.** Copy the chosen template folder to a working directory:
   ```bash
   cp -r templates/01-newsroom my-deck     # or: scripts/new-deck.sh my-deck 01-newsroom
   ```
   The folder is self-contained: `deck.html`, `assets/`, `vendor/` (bundled fonts + the capture
   library), and `build-standalone.py`.

3. **Fill the 12 slides.** Edit `my-deck/deck.html`. The slide block vocabulary (cover, statement,
   index, about, landscape, pillars, cards, team, numbers, roadmap, quote, closing) and how to map a
   brief onto it is in [references/slide-types.md](references/slide-types.md). Replace headlines,
   captions, stats, the footer running-title, and the `NN / 12` page numbers. Add, remove, or reorder
   blocks to fit the content. Keep the layout primitives intact (1600x900 stage, the `.slot` image
   pattern, no `z-index` on cut-image wrappers).

4. **Theme.** Each template ships a default palette plus switchable themes. To retune or derive a
   palette from a brand, see [references/palettes.md](references/palettes.md).

5. **Imagery.** Read [references/image-prompts.md](references/image-prompts.md). It carries the single
   most important rule: light themes white-point and bake imagery onto the background; dark themes
   (bg near black) must NOT bake, because multiplying onto near-black crushes the image to solid black.
   For the SVG templates there is nothing to generate. For the photo templates, reuse the bundled
   `assets/` art, or generate fresh topic-matched heroes with the companion `gemini-imagegen` skill
   (see Dependencies). The reusable collage library and a manifest are in `library/`.

6. **Build the single file.** From the deck folder:
   ```bash
   cd my-deck && python3 build-standalone.py     # writes deck-standalone.html
   ```
   This inlines the fonts, the capture library, and the images into one portable file.

7. **Verify, then deliver.** Serve and screenshot a few slides to check blends, overflow, and that the
   page numbers and title are consistent; fix positions in px against the 1600x900 stage. Hand the user
   `deck-standalone.html`. If they want a PDF artifact, the in-deck PDF button produces one, or run the
   template's `export-pdf.sh` (headless Chrome) for an exact render.

## What every deck can do, with no extra work

- **Navigate:** arrow keys, space, Home/End, on-screen controls, `#n` URL hash.
- **Switch palette** live from the toolbar.
- **Edit text in place** (press `E`), then **Save** (writes the HTML back, or downloads it).
- **Swap any image** in edit mode by clicking it or dropping a file on it (auto-downscaled).
- **Export a PDF** in one click that matches the screen exactly, fonts embedded.

## Writing rules

Write plainly. No em dashes. No filler, no jargon, no theatrics. Cut words like transform, empower,
seamless, elevate, leverage, robust. Short, declarative headlines; captions of one or two lines; one
idea per slide. Credibility comes from concrete, checkable claims, so this matters more than it looks.

## Reference files (read when you reach that step)

| File | Read it when |
|------|-------------|
| [TEMPLATES.md](TEMPLATES.md) | choosing a style; full palettes, fonts, layout signatures |
| [references/slide-types.md](references/slide-types.md) | filling the 12 slides; the block vocabulary |
| [references/palettes.md](references/palettes.md) | retuning or deriving a palette |
| [references/image-prompts.md](references/image-prompts.md) | generating or blending imagery (light vs dark rule) |
| `library/manifest.json` | picking a reusable collage asset by motif/aspect/use |
| `examples/fable5/` | a worked example: one report rendered through all ten styles |

## Dependencies

Viewing, editing, and exporting a deck need nothing installed; the output is self-contained and fonts
are bundled. Generating fresh imagery for the six photo templates uses the companion
[`gemini-imagegen`](https://github.com/anthropics/skills) skill at `$HOME/.claude/skills/gemini-imagegen`
and a `GEMINI_API_KEY` environment variable. This is optional and build-time only: the four SVG
templates never need it, and any photo template can ship with its bundled art.
