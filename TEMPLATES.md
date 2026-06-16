# Template Registry

Fifteen themed deck templates that share **one 12-slide backbone** (the style schema below) but fill it with
a distinct mood, palette, typography, visual medium, and layout signature. They live in
`templates/<id>-<name>/`; pick one by id and point it at an input (research dossier, repo, document,
chat, brief). The backbone is what makes them interchangeable; the fill is what makes each one feel like
a different studio made it.

---

## The backbone (shared YAML schema)

Every template is one of these, fully specified. This is the contract the build pipeline reads.

```yaml
template:
  id: "05"
  call: template-05
  name: Arena
  family: Sports
  best_for: [sponsorship deck, sports-business report, performance review]
  canvas: { ratio: "16:9", slides: 12, stage: [1600, 900] }
  mood: [high-energy, bold, kinetic, competitive]
  palette:
    bg: "#0E0E0E"
    ink: "#FFFFFF"
    ink_2: "#B5B5B5"
    paper: "#161616"
    accents: { primary: "#E8FF00", secondary: "#E2231A", c3: "#1E6BFF", c4: "#10B981", c5: "#FF7A00" }
  typography:
    heading: { family: "condensed grotesque", weight: 800, transform: uppercase, italic: true }
    body:    { family: "humanist sans", weight: 400 }
    figures: { family: "jersey numerals", feature: tabular }
  imagery:
    medium: duotone-photo            # collage | duotone-photo | painterly | geometric | charts | wireframe | ephemera
    motifs: [motion-blur athletes, halftone action, pitch lines, scoreboard]
    rendering: [high-contrast, diagonal slash, grain]
  layout:
    signature: [dynamic diagonals, oversized stat numbers, ticker strips, energetic asymmetry]
    blocks: [cover, statement, index, about, context, pillars, services, team, numbers, roadmap, quote, closing]
  effects: { texture: grain, shadows: hard }
  rules: [mono/duotone photo + 1 electric accent, no clip-art, stats are the hero]
```

Same 8 keys every time — `canvas, mood, palette, typography, imagery, layout, effects, rules` — plus
`id/call/name/family/best_for`. Swap the fill, keep the schema, and the pipeline (ingest → outline →
theme → assemble → image → PDF) works unchanged.

`layout.blocks` is the canonical 12-block backbone — `cover, statement, index, about, context,
pillars, services, team, numbers, roadmap, quote, closing` — shared verbatim by every template and by
`SKILL.md`. Each template relabels and restyles the blocks (slot 5 `context` is `THE MARKET` in Maison,
`THE FIELD` in Vanguard) but keeps the sequence. The per-block content levers are in
[references/slide-types.md](references/slide-types.md).

---

## The library (15 templates)

| # | Call | Codename | Family | Visual medium | Best input |
|---|------|----------|--------|---------------|-----------|
| 01 | `template-01` | **Newsroom** | Editorial collage | Sculpture + newsprint collage | Brand story, manifesto, research dossier |
| 02 | `template-02` | **Grid** | Mondrian / De Stijl | Primary color planes + black rules | Frameworks, design systems, modular breakdowns |
| 03 | `template-03` | **Plein Air** | Impressionist | Painterly washes + soft photography | Culture, vision, narrative, human topics |
| 04 | `template-04` | **Studio** | Creative agency | Bold duotone + type-as-hero | Pitches, portfolios, brand proposals |
| 05 | `template-05` | **Arena** | Sports | Motion duotone + stat call-outs | Sponsorship, sports business, performance |
| 06 | `template-06` | **Maison** | Luxury | Minimal Didone + jewel accent | Investor/board, premium brand, hospitality |
| 07 | `template-07` | **Drifter** | Hobo / earthy | Kraft ephemera collage | Travel, craft, sustainability, field reports |
| 08 | `template-08` | **Ledger** | Data / market research | Charts + mono + 1 signal color | Market research, financial, KPI, due diligence |
| 09 | `template-09` | **Terminal** | Coding / IT vintage | Monospace + schematic / punch-card | Repo summaries, architecture, AI/agent systems |
| 10 | `template-10` | **Vanguard** | Robotics / futuristic | Wireframe / HUD + neon | Deep-tech, robotics, R&D, futurist strategy |
| 11 | `template-11` | **Atrium** | Swiss / International Typographic | Type grid + one signal color | Enterprise, consulting, strategy, board, SaaS sales |
| 12 | `template-12` | **Vital** | Healthcare / wellness | Soft photo + rounded forms | Pharma, biotech, medtech, wellness, public health |
| 13 | `template-13` | **Marquee** | Cinematic photography | Full-bleed photo + Didone | Hospitality, real estate, travel, architecture, fashion |
| 14 | `template-14` | **Circuit** | Neon / cyberpunk | Neon SVG + glass HUD | Games, esports, crypto/web3, entertainment |
| 15 | `template-15` | **Almanac** | Academic / scientific | Figure plates + serif | Universities, think-tanks, policy, edtech, NGO |

### Palettes (the quick read)

| # | bg | ink | accents |
|---|----|-----|---------|
| 02 Grid | `#F4F3EF` | `#1A1A1A` | red `#D72A22` · blue `#1E3A8C` · yellow `#F2C400` (black grid rules) |
| 03 Plein Air | `#F3EEE2` | `#3A3631` | lavender `#B7A8D1` · sky `#9CC0DE` · wheat `#E9D8A6` · rose `#E5A6A1` · sage `#A9BE9C` |
| 04 Studio | `#F5F4F2` | `#111111` | acid `#C8FF3D` · coral `#FF5A3C` · cool grey `#8A8F98` |
| 05 Arena | `#0E0E0E` | `#FFFFFF` | electric `#E8FF00` · red `#E2231A` · blue `#1E6BFF` |
| 06 Maison | `#F1ECE3` | `#1B1A18` | gold `#B08D4C` · burgundy `#6E2433` · ink |
| 07 Drifter | `#EAE0CF` | `#3B3225` | terracotta `#C2683E` · mustard `#C9942F` · olive `#7C7A4A` · kraft `#9C7A4E` |
| 08 Ledger | `#FBFAF8` | `#16181D` | signal red `#E5484D` · grey ramp `#C9CCD1 → #3A3E47` |
| 09 Terminal | `#0A0E0A` (dark CRT) | `#E3FBE9` | phosphor green `#3BE26B` · amber `#FFB454` · cyan `#54D1E6` |
| 10 Vanguard | `#F2F5F7` (lab) | `#0A0F1C` | electric blue `#2B6BFF` · cyan `#19D3E0` · violet `#7A3CFF` · *(dark HUD variant: `#0A0F1C` + cyan glow)* |
| 11 Atrium | `#F7F6F3` | `#14161A` | signal red `#D8352A` · neutral grey ramp |
| 12 Vital | `#F2F6F4` | `#1E2A2A` | teal `#2F9E8F` · sage `#8FB89B` · sky `#7FB3D5` · coral `#E8907C` · amber `#E6B45A` |
| 13 Marquee | `#0E0E10` (dark) | `#FFFFFF` | gold `#C9A86A` · *(ivory light variant: `#F4F1EC`)* |
| 14 Circuit | `#0A0A12` (dark) | `#EAF0FF` | magenta `#FF2E97` · cyan `#21E6FF` · lime `#B6FF3C` · violet `#8A5CFF` |
| 15 Almanac | `#F4F0E6` (cream) | `#20242B` | ink-blue `#2A3A6B` · oxblood `#8A2B2B` |

---

## Per-template signatures

**02 · Grid (Mondrian / De Stijl)** — Rigid modular grid; content lives in rectangular cells of
unequal size separated by thick black rules; primary-color planes as accent blocks; the occasional
small B&W photo inset in a cell. Type is geometric, bold, uppercase. *Abandons collage for pure
geometric composition.* Great for anything structured and modular.

**03 · Plein Air (Impressionist)** — Broken pastel color, dappled light, painterly brushstroke fields
instead of torn paper; soft-edged photography toned in lavender/wheat; visible canvas texture. Refined
old-style serif headings + humanist sans. Airy, overlapping translucent washes. For warm, narrative,
human stories.

**04 · Studio (Creative agency)** — Type *is* the hero: oversized condensed/wide display sans, huge
numbers, full-bleed duotone image moments, sticker/label elements, confident negative space. One
electric accent on near-black/off-white. Portfolio energy. For pitches and brand proposals.

**05 · Arena (Sports)** — Motion-blur athlete duotones, halftone action, diagonal slashes, scoreboard
ticker strips, jersey-numeral stats as the hero. Athletic condensed italic grotesque. Dark, high-
contrast, kinetic. Directly serves your sports-sponsorship work.

**06 · Maison (Luxury)** — Restraint: bone/ivory, charcoal, a single gold or burgundy jewel accent,
huge negative space, high-contrast Didone headlines, hairline rules, large quietly-toned photography.
For board, investor, and premium-brand decks.

**07 · Drifter (Hobo / earthy)** — Scrapbook of kraft paper, stamps, ticket stubs, twine, postmarks,
route maps, sepia photography; woodtype/slab headlines + typewriter body. Taped, layered, handcrafted.
For travel, artisanal brands, sustainability, field notes.

**08 · Ledger (Data / market research)** — Tufte-clean and monochromatic with **one** signal color;
the "visual assets" are sparklines, small multiples, dot-plots, tables, and the occasional duotone
photo. Grotesque + mono tabular figures. Dense but ordered, footnoted, sourced. *Abandons collage for
charts.* For analyst, financial, and research decks.

**09 · Terminal (Coding / IT)** — A dark CRT console: black-green phosphor on near-black, real terminal
windows (traffic-light dots, `$` prompts), ASCII frames, circuit traces, and schematic line diagrams,
with subtle scanlines. Monospace throughout. For repos, architecture, agent/AI systems.

**10 · Vanguard (Robotics / futuristic)** — Wireframe/HUD overlays, exploded isometric mech renders,
blueprint line-art, sensor scans, glowing nodes, targeting reticles; wide techy grotesque + mono.
Light "lab" theme + dark "HUD" variant. For deep-tech, robotics, R&D.

**11 · Atrium (Swiss / International Typographic)** — Strict column grid, generous whitespace, hairline
rules, flush-left Inter Tight headings with small mono kicker labels, near-monochrome with a single
rationed signal color. Big quiet numerals, no decoration. *Trades collage for disciplined type.* For
enterprise, consulting, strategy, and board decks.

**12 · Vital (Healthcare / wellness)** — Calm mint-white with teal/sage/sky, rounded corners and soft
shadows, humanist Mulish throughout, accessible contrast, gentle line icons, soft photography.
Reassuring and clear, not arty. For pharma, biotech, medtech, wellness, and public health.

**13 · Marquee (Cinematic photography)** — Edge-to-edge photography with gradient scrims, light
high-contrast Bodoni hero lines, wide-tracked Jost captions, a single thin gold rule, deep cinematic
negative space. Dark by default with a light ivory variant. Hero images composite normally (no
multiply) so the dark background never crushes them. For hospitality, real estate, travel,
architecture, and fashion.

**14 · Circuit (Neon / cyberpunk)** — Deep indigo-black with magenta/cyan/lime/violet neon, glow on
accents and numerals, glassmorphic HUD panels, a scan-grid horizon, Chakra Petch display over Space
Grotesk and Space Mono. Wireframe schematics recolored to neon gradient strokes; body text stays
full-legibility. *A vibrant counterpart to Terminal's retro green and Vanguard's clean lab HUD.* For
games, esports, crypto/web3, and entertainment.

**15 · Almanac (Academic / scientific)** — Cream paper, Playfair serif heads over humanist Mulish body,
two-column text, numbered figure plates with captions, footnotes and source citations, hairline rules,
a single restrained scholarly accent. *Trades collage for a typeset paper.* For universities, research
institutes, think-tanks, policy, and NGO findings.

---

## Imagery medium

Each template declares an `imagery.medium`. Collage, duotone-photo, painterly, ephemera, and cinematic
templates (01, 03, 04, 05, 06, 07, 12, 13) use photographic or generated imagery via the
`gemini-imagegen` skill; geometric, charts, wireframe, neon, and figure templates (02, 08, 09, 10, 11,
14, 15) render their visuals as inline SVG (or reuse bundled figure plates) and need no image
generation.
