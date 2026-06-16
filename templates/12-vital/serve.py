#!/usr/bin/env python3
"""Serve the deck and expose /export.pdf for one-click, pixel-exact PDF download.

  python3 serve.py [port] [deck.html]

/export.pdf renders the deck with headless Chrome using the deck's print CSS
(one 1600x900 page per slide, backgrounds on, no margins) and returns it as a
download. This avoids the browser's Save-as-PDF dialog and its white margins.
"""
import http.server, subprocess, tempfile, os, sys, shutil

PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 8942
DECK = sys.argv[2] if len(sys.argv) > 2 else "deck.html"

def find_chrome():
    for p in ["/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
              "/Applications/Chromium.app/Contents/MacOS/Chromium"]:
        if os.path.exists(p):
            return p
    return shutil.which("google-chrome") or shutil.which("chromium")

CHROME = find_chrome()

class Handler(http.server.SimpleHTTPRequestHandler):
    def log_message(self, *a):  # quiet
        pass

    def do_GET(self):
        if self.path.split("?")[0].rstrip("/") in ("/export.pdf", "/export"):
            return self.export_pdf()
        return super().do_GET()


    def export_pdf(self):
        if not CHROME:
            self.send_error(500, "Chrome/Chromium not found")
            return
        tmp = tempfile.mktemp(suffix=".pdf")
        try:
            subprocess.run(
                [CHROME, "--headless=new", "--disable-gpu", "--no-pdf-header-footer",
                 f"--print-to-pdf={tmp}", f"http://localhost:{PORT}/{DECK}"],
                check=True, timeout=120,
                stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            with open(tmp, "rb") as f:
                data = f.read()
            self.send_response(200)
            self.send_header("Content-Type", "application/pdf")
            self.send_header("Content-Disposition", 'attachment; filename="deck.pdf"')
            self.send_header("Content-Length", str(len(data)))
            self.send_header("Cache-Control", "no-store")
            self.end_headers()
            self.wfile.write(data)
        except Exception as e:
            self.send_error(500, f"export failed: {e}")
        finally:
            if os.path.exists(tmp):
                os.remove(tmp)

if __name__ == "__main__":
    http.server.ThreadingHTTPServer.allow_reuse_address = True
    srv = http.server.ThreadingHTTPServer(("", PORT), Handler)
    print(f"serve.py on http://localhost:{PORT}  deck={DECK}  (/export.pdf ready, chrome={'yes' if CHROME else 'NO'})")
    srv.serve_forever()
