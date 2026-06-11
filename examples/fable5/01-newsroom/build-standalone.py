#!/usr/bin/env python3
"""Inline fonts, the capture library, and images into ONE self-contained deck.

  python3 build-standalone.py

Produces deck-standalone.html: a single file with no external assets. Open it
anywhere (even straight from disk) and the PDF button works with correct fonts.
"""
import base64, re, pathlib

d = pathlib.Path(__file__).parent
html = (d / "deck.html").read_text(encoding="utf-8")

# 1. Fonts: inline fonts.css, each woff2 as a data URI.
fonts_css = (d / "vendor/fonts/fonts.css").read_text(encoding="utf-8")
def woff2(m):
    b = (d / "vendor/fonts" / m.group(1)).read_bytes()
    return "url(data:font/woff2;base64," + base64.b64encode(b).decode() + ")"
fonts_css = re.sub(r"url\((f\d+\.woff2)\)", woff2, fonts_css)
html = html.replace('<link rel="stylesheet" href="vendor/fonts/fonts.css">',
                    "<style>\n" + fonts_css + "\n</style>")

# 2. Capture library: inline.
lib = (d / "vendor/html-to-image.js").read_text(encoding="utf-8")
html = html.replace('<script src="vendor/html-to-image.js"></script>',
                    "<script>\n" + lib + "\n</script>")

# 3. Images: inline every assets/*.jpg reference as a data URI.
def data_uri(name):
    b = (d / "assets" / name).read_bytes()
    return "data:image/jpeg;base64," + base64.b64encode(b).decode()
html = re.sub(r'src="assets/([^"]+\.jpg)"', lambda m: 'src="' + data_uri(m.group(1)) + '"', html)
html = re.sub(r'url\("assets/([^"]+\.jpg)"\)', lambda m: 'url("' + data_uri(m.group(1)) + '")', html)

out = d / "deck-standalone.html"
out.write_text(html, encoding="utf-8")
mb = len(out.read_bytes()) / 1024 / 1024
print(f"wrote {out.name}  ({mb:.1f} MB, fully self-contained)")
