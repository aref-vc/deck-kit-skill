# Slide-type vocabulary

Every template is a working **12-slide** deck at `templates/<id>-<name>/deck.html`. Each
`<section class="slide">` is one self-contained, absolutely-positioned block on a 1600×900 stage.
To build a new deck, **clone a template and rewrite the content of each block**, adding, removing, or
reordering blocks as the outline needs. Below is the canonical vocabulary — the twelve blocks, what
each is for, and the levers to pull.

The **twelve blocks are the same slot sequence in every template**; only the per-template label and
styling change. Slot 5, for example, is `THE LANDSCAPE` in Newsroom, `THE MARKET` in Maison, `THE
FIELD` in Vanguard, and `MARKET LANDSCAPE` in Ledger — same block, different dressing. The class names
below are Newsroom's (the reference deck); other templates restyle them but keep the block roles.

## The canonical backbone (12 blocks)

| # | Block | Purpose | Reference label(s) |
|---|-------|---------|--------------------|
| 1 | **cover** | Title slide | COVER |
| 2 | **statement** | One-line thesis / intent | STATEMENT, MANIFESTO |
| 3 | **index** | Numbered contents | INDEX |
| 4 | **about** | Who or what this is | ABOUT, THE CLUB, THE HOUSE |
| 5 | **context** | The situation the work sits in | THE LANDSCAPE, THE MARKET, THE FIELD, MARKET LANDSCAPE |
| 6 | **pillars** | The approach, as 5 parallel items | HOW WE WORK / BUILD / PLAY / MAKE |
| 7 | **services** | The offering, as 3 cards | WHAT WE DO / MAKE / BUILD, THE COLLECTIONS, COVERAGE |
| 8 | **team** | People, 6 placeholders | THE TEAM, THE SQUAD, THE ATELIER, THE CREW |
| 9 | **numbers** | The key stats | BY THE NUMBERS, THE NUMBERS |
| 10 | **roadmap** | Time sequence, 6 milestones | ROADMAP, THE SEASON PLAN, OUTLOOK, THE PLAN |
| 11 | **quote** | One pull-quote with attribution | PERSPECTIVE |
| 12 | **closing** | Sign-off and contact | CONTACT |

These twelve names — `cover, statement, index, about, context, pillars, services, team, numbers,
roadmap, quote, closing` — are the shared vocabulary used in `SKILL.md` and `TEMPLATES.md`. Aim for
8–14 slides in a finished deck: drop blocks the material doesn't need, or duplicate one (e.g. a second
`context` or a divider) where it does.

## Layout primitives (shared)

- **Stage:** fixed `1600 × 900`. Everything is positioned in px against it; it auto-scales to the
  viewport via a transform, and prints 1:1.
- **`.slot`** — an image container. It holds an `<img class="cut">` plus a `.ph` placeholder div
  (`style="--c:var(--accent)"`, optional `<svg class="phg"><use href="#g-…"/></svg>` glyph). The
  `onerror` handler adds `.noimg` so a missing image degrades to the colored placeholder. This is the
  one pattern every image goes through — the inline editor's image-swap wires onto `.slot`.
- **`img.cut`** — a collage cutout. Always `mix-blend-mode:multiply` so its white-pointed background
  melts into `--bg`. **Never wrap a `.cut` image in a `z-index`'d container** — that creates a
  stacking context and breaks the blend. Give text layers `z-index:10` instead.
- **`.scrap`** — torn-newspaper texture tiles (corners/edges). **`.foot`** — running footer, two spans:
  deck title and the printed `NN / 12` page number. **`.eyebrow` `.kicker` `.rule` `.plus` `.dotgrid`**
  — small editorial accents. The grain overlay is automatic via `.slide::after`.
- Headline scale: `h1` ~96–122px (cover/closing), `h2` ~58–64px (content titles), `h3` ~21px (labels);
  `.body` for prose, `.small` for captions.

## Block detail

| # | Block | Content levers (Newsroom classes) | Library role |
|---|-------|-----------------------------------|--------------|
| 1 | **cover** | `.eyebrow`, big `h1` (1–3 lines), accent `.rule`, `.kicker` subtitle, one tall `.slot` | `role:hero` (4:5) |
| 2 | **statement** | `.kicker` label, oversized `h2` thesis (~62px), one `.body` line, one square `.slot` | `role:figure` (1:1) |
| 3 | **index** | `.index-list` of `.index-row` (`.num` + `h3` + `.pg`), 6–8 items, edge `.slot` | `role:edge-strip` (3:4) |
| 4 | **about** | `h2`, `.body` paragraph, `.kicker` meta line, one `.slot` figure | `role:figure` (3:4) |
| 5 | **context** | `h2`, `.twocol` (two `h3` + `.body` columns), one wide `.slot` | `role:feature` (16:9) |
| 6 | **pillars** | `h2`, one wide row `.slot` (`pillars-row`), 5 `.rowlabel` (`h3` + `.small`) under it | `role:row` (21:9) |
| 7 | **services** | `h2`, `.dotgrid` accent, `.col3` of 3 `.cell` (square `.slot` + `h3` + `.small`) | `role:card` (1:1) ×3 |
| 8 | **team** | `h2`, one wide row `.slot` (`team-row`), 6 `.rowlabel` (name + role) | `role:row` (21:9) |
| 9 | **numbers** | `h2`, one feature `.slot`, `.stats` of 4 `.stat` (`.statnum` + `.statlabel` + `.bar`), source `.small` | `role:feature` (1:1) |
| 10 | **roadmap** | `h2`, `.tl-year` labels, wide row `.slot`, `.tl-line` + `.tl-dot` ×6, `.rowlabel` captions | `role:row` (21:9) |
| 11 | **quote** | `.kicker`, oversized `h2` quote (~58px), `.body` attribution, one tall `.slot` bleeding off an edge | `role:hero` (3:4) |
| 12 | **closing** | `.scrap`, one `.slot`, big `h1`, `.body` line, `.contact` rows (icon `svg` + text) | `role:hero` (3:4) |

### Composing extra blocks (same primitives, not in the base 12)

- **Section divider:** giant `.num` (`01`), `h2` chapter name, `.kicker`, one-line intro, one `role:hero`
  image. Insert before a major chapter when a deck runs long.
- **Two-column editorial:** the `context` pattern (`.twocol`) under any `h2`, with a `.cut` accent
  floating across the gutter.
- **Full-bleed statement:** reuse the `closing` block, swap content — a single `h1` with one large
  collage off the opposite edge.

## Outline → blocks (default mapping)

1. **cover** · 2. **statement** · 3. **index** · 4. **about** · 5. **context** · 6. **pillars** ·
7. **services** · 8. **team** · 9. **numbers** · 10. **roadmap** · 11. **quote** · 12. **closing**.

Keep the spine, fill each block from the brief, and cut any block the material doesn't earn. Insert a
divider before each major chapter when the deck grows past ~12 slides.

## Editing rules

- One idea per slide; headlines short and declarative; captions ≤ 2 lines.
- Replace the footer title (`Meridian · 2026`) with the deck's running title, and renumber `NN / 12`
  on every slide to match the final count. The on-screen counter is automatic; the printed `.foot`
  string is hardcoded per slide, so update all of them.
- Mix monochrome photos with **accent color shapes**; never use corporate clip-art icons (the inline
  SVG line icons in stat blocks and contact rows are fine — they're hand-weighted, not stock).
</content>
</invoke>
