# Palettes

Five accent "slots" + surface tokens, defined as CSS custom properties on a `body.theme-*` class.
Swapping the class reskins every **CSS-drawn** element (process circles, tape, kicker text, agenda
numbers, dividers, dot grids, the slide background). The **collage photos keep their baked-in accent
shapes** — to fully match a palette, regenerate imagery in that palette (see `image-prompts.md`).

| Token | Meaning |
|---|---|
| `--bg` | slide paper background |
| `--ink` / `--ink-2` | primary / secondary text |
| `--paper` | stat-card / inset surface |
| `--red` | primary accent (slot 1) |
| `--cyan` | secondary accent (slot 2) |
| `--yellow` `--olive` `--peach` | supporting accents (slots 3-5) |

## Built-in themes

```css
.theme-newsroom{ /* default, retuned off the source reference */
  --bg:#ECECEC; --ink:#1E1E1E; --ink-2:#565656; --paper:#F6F4EE;
  --red:#E5443B; --cyan:#34C5CE; --yellow:#ECC94B; --olive:#C2CE86; --peach:#F0AA8B; }

.theme-riso{ /* electric blue + hot pink */
  --bg:#F2EFE6; --ink:#1A1A2E; --ink-2:#5A5A6E; --paper:#FBFAF4;
  --red:#F8487F; --cyan:#3D5AFE; --yellow:#FFC400; --olive:#26C281; --peach:#FF8A65; }

.theme-noir{ /* high-contrast mono + one red */
  --bg:#E9E7E2; --ink:#161616; --ink-2:#4F4F4F; --paper:#F4F2EC;
  --red:#E5403A; --cyan:#9AA0A6; --yellow:#C9C2B0; --olive:#B8BCAE; --peach:#CDC4BB; }

.theme-botanic{ /* terracotta, sage, mustard */
  --bg:#EDE9DF; --ink:#2B2A26; --ink-2:#5E5B50; --paper:#F6F2E8;
  --red:#CE5B3C; --cyan:#5FA6B5; --yellow:#E0A52E; --olive:#7E8C4F; --peach:#E5A07C; }
```

## Adding a theme

1. Append a `.theme-yourname{ ... }` block redefining the eight tokens.
2. Add `yourname` to the `<select id="theme">` options and the `THEMES` array in the script.
3. Keep `--bg` in a **light** range (≈ #E8–#F4). The library photos were white-pointed to ~#ECECEC;
   a very different `--bg` tints their near-white areas through `multiply` (subtle, usually fine; a
   dark `--bg` will not work without regenerated, dark-matched imagery).

## Deriving a palette from a brand / topic

- Pick the brand's primary as `--red` (slot 1) and a complementary as `--cyan` (slot 2); fill 3-5 with
  muted tints so the page stays editorial, not corporate.
- Keep text near-black on light paper for the newsprint feel. Avoid pure #000/#FFF.
