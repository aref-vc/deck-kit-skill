#!/usr/bin/env python3
"""Add the image-swap feature (click-in-place + drag-and-drop) to a deck's image slots.

In Edit mode, every photo slot (.slot containing an <img>) becomes replaceable: click it to
pick a file, or drop an image onto it. The import is downscaled to <=1600px and re-encoded as
JPEG, then set as the image src (a data URL), so Save and the PDF export capture it automatically.
Idempotent: skips files already carrying the feature. Geometric (SVG-only) slots are untouched.

  python3 add-image-swap.py
"""
import pathlib

ROOT = pathlib.Path(__file__).resolve().parents[2]  # the repo root
# every template, plus any example decks
FILES = sorted((ROOT / "deck-kit/templates").glob("*/deck.html")) \
      + sorted((ROOT / "deck-kit/examples").glob("*/*/deck.html"))

CSS = """
  /* ---- IMGSWAP_FEATURE: click or drop to replace an image (edit mode only) ---- */
  .imgedit-cue{display:none}
  body.editing .imgedit{cursor:pointer;z-index:50;outline:1.5px dashed rgba(128,128,128,.6);outline-offset:3px}
  body.editing .imgedit .imgedit-cue{display:flex;align-items:center;gap:6px;position:absolute;left:50%;top:50%;transform:translate(-50%,-50%);background:rgba(17,17,17,.66);color:#fff;font:600 12px/1 -apple-system,system-ui,sans-serif;letter-spacing:.03em;padding:8px 12px;border-radius:5px;opacity:0;transition:opacity .14s;pointer-events:none;white-space:nowrap;z-index:61}
  body.editing .imgedit:hover .imgedit-cue,body.editing .imgedit.dragover .imgedit-cue{opacity:1}
  body.editing .imgedit.dragover{outline:2px solid #2FD7E5;outline-offset:3px}
"""

JS = r"""<script>
/* IMGSWAP_FEATURE: click-in-place + drag-and-drop image replacement (Edit mode only) */
(function(){
  var MAX=1600,Q=0.85;
  var input=document.createElement('input');input.type='file';input.accept='image/*';input.style.display='none';document.body.appendChild(input);
  var target=null;
  function editing(){return document.body.classList.contains('editing');}
  function setImage(slot,url){var img=slot.querySelector('img');if(!img)return;img.removeAttribute('srcset');img.src=url;slot.classList.remove('noimg');}
  function processFile(slot,file){
    if(!file||!/^image\//.test(file.type))return;
    var fr=new FileReader();
    fr.onload=function(){
      var im=new Image();
      im.onload=function(){
        var w=im.naturalWidth,h=im.naturalHeight,s=Math.min(1,MAX/Math.max(w,h));
        var cw=Math.max(1,Math.round(w*s)),ch=Math.max(1,Math.round(h*s));
        var c=document.createElement('canvas');c.width=cw;c.height=ch;
        c.getContext('2d').drawImage(im,0,0,cw,ch);
        var out;try{out=c.toDataURL('image/jpeg',Q);}catch(e){out=fr.result;}
        setImage(slot,out);
      };
      im.onerror=function(){setImage(slot,fr.result);};
      im.src=fr.result;
    };
    fr.readAsDataURL(file);
  }
  input.addEventListener('change',function(){if(target&&input.files&&input.files[0])processFile(target,input.files[0]);target=null;input.value='';});
  function wire(slot){
    slot.classList.add('imgedit');
    if(!slot.querySelector('.imgedit-cue')){var cue=document.createElement('span');cue.className='imgedit-cue';cue.textContent='Click or drop image';slot.appendChild(cue);}
    slot.addEventListener('click',function(e){if(!editing())return;e.preventDefault();e.stopPropagation();target=slot;input.click();});
    slot.addEventListener('dragover',function(e){if(!editing())return;e.preventDefault();slot.classList.add('dragover');});
    slot.addEventListener('dragleave',function(){slot.classList.remove('dragover');});
    slot.addEventListener('drop',function(e){if(!editing())return;e.preventDefault();slot.classList.remove('dragover');var f=e.dataTransfer&&e.dataTransfer.files&&e.dataTransfer.files[0];if(f)processFile(slot,f);});
  }
  function init(){document.querySelectorAll('.slot').forEach(function(s){if(s.querySelector(':scope > img'))wire(s);});}
  if(document.readyState==='loading')document.addEventListener('DOMContentLoaded',init);else init();
})();
</script>"""

for f in FILES:
    html = f.read_text(encoding="utf-8")
    if "IMGSWAP_FEATURE" in html:
        print("skip (already has it):", f.relative_to(ROOT)); continue
    html = html.replace("</style>", CSS + "</style>", 1)
    html = html.replace("</body>", JS + "\n</body>", 1)
    f.write_text(html, encoding="utf-8")
    print("injected:", f.relative_to(ROOT))
