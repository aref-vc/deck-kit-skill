#!/usr/bin/env python3
"""Behavioral guard: render each deck in headless Chrome and assert that, in Edit mode,
ALL slide text is editable, EVERY slide image is swappable, and nothing covers the text.

This catches the three editing regressions that static checks can't see:
  1. text that won't edit  (a deck reverts to a hardcoded editable-class list)
  2. images that won't swap (image-swap wired only to .slot, missing new wrappers)
  3. text hidden in edit mode (an image/overlay painted over its own caption)

It loads each deck, enters Edit mode, walks every slide, and reports three counts that
must all be zero. Uses headless Chrome (already required for PDF export); if Chrome is
not found it skips cleanly so it never blocks a machine without it.

  python3 scripts/check-edit.py            # check every template + example deck
  python3 scripts/check-edit.py templates/13-marquee/deck.html   # one deck
"""
import json, os, pathlib, re, shutil, subprocess, sys, tempfile

ROOT = pathlib.Path(__file__).resolve().parents[1]

def find_chrome():
    for p in ("/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
              "/Applications/Chromium.app/Contents/MacOS/Chromium"):
        if os.path.exists(p):
            return p
    return shutil.which("google-chrome") or shutil.which("chromium")

# In-page probe: enter Edit mode, then for every slide tally
#  - text leaves that did NOT become editable
#  - slide <img> whose wrapper was not wired for swap
#  - text leaves that are covered (hit-tested top element is an image/swap wrapper)
# The image-swap hint (.imgedit-cue) and the toolbar are excluded; invisible nodes are
# skipped for the covered-text hit test. Result is written to document.title.
PROBE = r"""
<script>
window.addEventListener('load',function(){ setTimeout(function(){
 try{
  var btn=document.getElementById('editBtn')||[].slice.call(document.querySelectorAll('button,[role=button]'))
            .find(function(b){return /edit/i.test(b.textContent||'');});
  if(btn && !document.body.classList.contains('editing')) btn.click();
  function skip(el){return el.classList.contains('imgedit-cue')||(el.closest&&(el.closest('.imgedit-cue')||el.closest('.toolbar')));}
  function hasText(el){var cn=el.childNodes;for(var i=0;i<cn.length;i++){if(cn[i].nodeType===3&&cn[i].textContent.trim())return true;}return false;}
  var R={edit:document.body.classList.contains('editing'),textLeaks:0,unwiredImgs:0,coveredText:0,leak:[],cover:[]};
  // 1) every text leaf must be contenteditable (works on hidden slides too; it's a DOM check)
  document.querySelectorAll('.slide *').forEach(function(el){
    if(skip(el)||!hasText(el))return;
    if(el.getAttribute('contenteditable')!=='true'){R.textLeaks++;if(R.leak.length<8)R.leak.push((el.tagName+'.'+el.className).trim().slice(0,44));}
  });
  // 2) every slide image must be wired for swap (its wrapper carries .imgedit)
  document.querySelectorAll('.slide img').forEach(function(img){
    var p=img.parentElement;if(!p||!p.classList.contains('imgedit')){R.unwiredImgs++;if(R.leak.length<8)R.leak.push('unwired:'+(img.getAttribute('src')||'').split('/').pop());}
  });
  // 3) no text leaf may be covered by an image/swap wrapper in edit mode (per slide, hit-tested)
  var slides=[].slice.call(document.querySelectorAll('.slide'));
  slides.forEach(function(sl){
    slides.forEach(function(s){s.classList.remove('active');});
    sl.classList.add('active');
    void document.body.offsetHeight;
    sl.querySelectorAll('*').forEach(function(el){
      if(skip(el)||!hasText(el))return;
      var cs=getComputedStyle(el);
      if(cs.visibility==='hidden'||cs.display==='none'||parseFloat(cs.opacity)===0)return;
      var r=el.getBoundingClientRect();if(r.width<3||r.height<3)return;
      var x=r.left+Math.min(r.width/2,r.width-3), y=r.top+Math.min(r.height/2,r.height-3);
      var top=document.elementFromPoint(x,y);
      if(top&&top!==el&&!el.contains(top)){
        var covered = top.tagName==='IMG' || (top.closest&&top.closest('.imgedit'));
        if(covered){R.coveredText++;if(R.cover.length<8)R.cover.push(((el.className||el.tagName)+' < '+(top.className||top.tagName)).slice(0,52));}
      }
    });
  });
  document.title='DECKCHK '+JSON.stringify(R);
 }catch(e){document.title='DECKCHK ERR '+(e&&e.message||e);}
}, 200); });
</script>
"""

def check_deck(chrome, deck: pathlib.Path):
    html = deck.read_text(encoding="utf-8")
    if "</body>" not in html:
        return {"ok": False, "err": "no </body> to inject probe"}
    tmp = deck.parent / ".editcheck.tmp.html"
    tmp.write_text(html.replace("</body>", PROBE + "\n</body>", 1), encoding="utf-8")
    try:
        out = subprocess.run(
            [chrome, "--headless=new", "--disable-gpu", "--no-sandbox",
             "--window-size=1600,900", "--virtual-time-budget=6000", "--dump-dom",
             "file://" + str(tmp)],
            capture_output=True, text=True, timeout=90).stdout
    except subprocess.TimeoutExpired:
        tmp.unlink(missing_ok=True)
        return {"ok": False, "err": "render timeout"}
    finally:
        tmp.unlink(missing_ok=True)
    m = re.search(r"<title>DECKCHK (.*?)</title>", out, re.S)
    if not m:
        return {"ok": False, "err": "no probe result (render failed)"}
    payload = m.group(1)
    if payload.startswith("ERR "):
        return {"ok": False, "err": "probe error: " + payload[4:]}
    try:
        r = json.loads(payload)
    except Exception as e:
        return {"ok": False, "err": "bad probe json: %s" % e}
    r["ok"] = (r.get("edit") and r["textLeaks"] == 0 and r["unwiredImgs"] == 0 and r["coveredText"] == 0)
    return r

def main():
    chrome = find_chrome()
    if not chrome:
        print("check-edit: Chrome/Chromium not found - render check skipped"); return 0
    args = sys.argv[1:]
    if args:
        decks = [pathlib.Path(a).resolve() for a in args]
    else:
        decks = sorted((ROOT/"templates").glob("*/deck.html")) + sorted((ROOT/"examples").glob("*/*/deck.html"))
    if not decks:
        print("no decks found"); return 2
    fails = []
    for d in decks:
        r = check_deck(chrome, d)
        rel = d.relative_to(ROOT)
        if r.get("ok"):
            print(f"  ok   {rel}")
        else:
            detail = r.get("err") or f"textLeaks={r.get('textLeaks')} unwiredImgs={r.get('unwiredImgs')} coveredText={r.get('coveredText')} {r.get('leak',[])} {r.get('cover',[])}"
            print(f"  FAIL {rel}: {detail}")
            fails.append(rel)
    print(f"\nrendered {len(decks)} decks; {len(fails)} failed")
    return 1 if fails else 0

if __name__ == "__main__":
    sys.exit(main())
