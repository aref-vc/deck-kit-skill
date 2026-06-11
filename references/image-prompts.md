# Imagery — hybrid strategy

**Reuse the library for most slides; generate only the bespoke heroes.** Per deck, generate fresh:
the **cover** hero, each **section-divider** hero, and the **closing** hero (these carry the topic).
Inner cards / timeline / accents reuse `library/` unless the topic demands something specific.

## Generate

```bash
$HOME/.claude/skills/gemini-imagegen/scripts/generate_image.py "PROMPT" out.jpg --aspect 4:5 --size 2K
```

Then make it blend into the slide background. **The method depends on whether the theme is light or
dark — getting this wrong is the single most common way to ruin a deck.**

### Light themes (bg ≈ #E8–#F6): white-point, then bake the multiply

```bash
# 1) white-point so the image background goes to pure white
magick out.jpg -level 0%,88% -quality 90 out.jpg
# 2) bake the multiply onto the slide bg, so it blends with NORMAL compositing
#    (no mix-blend-mode needed at render time, so the in-browser PDF export stays accurate)
magick out.jpg \( -clone 0 -fill "#ECE8E1" -colorize 100 \) -compose multiply -composite -quality 90 out.jpg
```

Use the theme's own `--bg` hex in the bake, not the literal above.

### Dark themes (bg ≈ #0A–#1A): DO NOT bake — place directly

**Never run the multiply bake against a dark background.** Multiplying any image by a near-black colour
crushes every pixel to black (an image baked onto `#0E0E0E` measures ~1–4 / 255 brightness — it
becomes the "dark layer", not a photo). Instead:

```bash
# generate with the DARK bg named in the prompt (e.g. "...on a near-black #0E0E0E background..."),
# then only lift the black point a touch so shadows merge into the slide. No multiply.
magick out.jpg -level 5%,100% -quality 90 out.jpg
```

For dark photo themes, prompt for low-key, dark-background imagery with a single rim-light accent so the
photo's own background already matches the slide. The image sits in its slot with normal compositing.

## Prompt formula

> Editorial avant-garde mixed-media collage cutout: **[monochrome B&W subject — classical sculpture /
> vintage photo / object tied to the topic]**, layered over **[flat torn paper shape in ACCENT]** ,
> with **[1-2 secondary motifs: torn newsprint, planet, clouds, halftone circle, ink scribble]**.
> Torn paper edges, newsprint texture, paper grain, halftone analog imperfections. Plain light gray
> paper background hex **#ECECEC** filling all empty space. No text, no letters, no watermark.

Rules that keep it on-brand:
- Subjects **monochrome**; color comes only from the **flat paper accent shapes** (match the chosen
  theme's hex, not the default, if you want palette-true imagery).
- Name the exact `#ECECEC` (or the theme `--bg`) so the background is uniform and white-points cleanly.
- Always end with "No text, no letters, no watermark."
- Classical sculpture (busts, Roman/Greek statues, marble hands/eyes) is the signature motif — lean on it.
- Aspect by role: cover/divider/closing **4:5 or 3:4**, cards **1:1**, timeline row **21:9**, accents 1:1.

## Topic adaptation

Swap the sculpture's pairing for a topic-tied monochrome object: finance → vintage ticker tape /
columns; space → planets / rockets (already in library); nature → botanicals / seedlings; tech →
old cameras / circuitry; sport → motion-blur athletes. Keep the marble + torn-newsprint frame so the
deck stays cohesive.

## Cost / latency

Each generation ≈ 30-60s + API cost. A typical deck regenerates **3-5 heroes** (cover + dividers +
closing) and reuses everything else → fast and cheap while still feeling bespoke.
