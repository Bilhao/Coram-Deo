#!/usr/bin/env python3
"""
tools/fix_three_saints.py
Regenera cirurgicamente com prompts aprimorados:
- 11/09: Dedicação da Basílica de Latrão (sem a maquete de brinquedo; Papa São Silvestre abençoando com a fachada ao fundo)
- 06/29: Santos Pedro e Paulo (mãos perfeitas e naturais, sem sobreposição confusa de espadas e chaves)
- 09/08: Natividade de Nossa Senhora (Santa Ana com mãos perfeitas e delicadas, sem 6 dedos e sem auréola estranha)
"""

import os
import sys

PROJECT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if PROJECT_DIR not in sys.path:
    sys.path.insert(0, PROJECT_DIR)

import time
import base64
from tools.saint_image_daemon import (
    create_client,
    crop_letterbox_and_convert,
    validate_image_visual,
    update_db_image_url,
    IMAGES_DIR,
    log,
)

PROMPTS = {
    (9, 11): (
        "Direct digital illustration in pure classic baroque sacred oil painting style, filling 100% of the square image seamlessly edge-to-edge. "
        "CRITICAL: Absolutely borderless, full-bleed, NO physical canvas edge, NO miniature dollhouse model in hands, NO photo of painting, NO picture frame, NO easel, NO wall. "
        "Close-up upper-body portrait for the Feast of the Dedication of the Archbasilica of Saint John Lateran (Dedicação da Basílica de Latrão). "
        "Pope Saint Sylvester I (Papa São Silvestre) in majestic ancient papal liturgical vestments, wearing a richly embroidered golden cope with jewels and an ancient white pallium with dark crosses. "
        "Venerable, holy elderly countenance with white beard. "
        "His right hand is gracefully raised in solemn episcopal blessing with exactly five natural, well-separated, perfectly proportioned fingers. "
        "His left hand holds a golden papal cross staff with five natural fingers. "
        "In the deep atmospheric chiaroscuro background behind him, the monumental classical facade and statues of the Archbasilica of Saint John Lateran are softly illuminated by warm celestial divine golden light and drifting incense. "
        "Delicate translucent golden halo glowing softly above his head. Masterwork in the style of Diego Velazquez and Francisco de Zurbaran."
    ),
    (29, 6): (
        "Direct digital illustration in pure classic baroque sacred oil painting style, filling 100% of the square image seamlessly edge-to-edge. "
        "CRITICAL: Absolutely borderless, full-bleed, NO physical canvas edge, NO photo of painting, NO picture frame, NO easel, NO wall. "
        "Close-up bust portrait of the two Princes of the Apostles, Saint Peter and Saint Paul (Santos Pedro e Paulo), side by side in sacred communion and brotherly devotion. "
        "On the left, Saint Peter with grey hair and beard, wearing blue tunic and golden-brown mantle; his left hand gently holds a pair of antique golden keys against his chest with five clear natural fingers, while his right hand rests calmly over his heart with five distinct natural fingers. "
        "On the right, Saint Paul with noble high forehead, dark beard, wearing crimson tunic and deep green mantle; his hands rest serenely holding a closed leather-bound Bible with five clearly defined, natural fingers on each hand (NO loose floating fingers, NO awkward sword grip). "
        "Both faces filled with apostolic courage, serenity, and deep faith. "
        "Delicate translucent golden halos glowing softly above each head. "
        "Dramatic chiaroscuro warm golden light against a deep velvety dark background, masterwork in the style of Caravaggio and Francisco de Zurbaran."
    ),
    (8, 9): (
        "Direct digital illustration in pure classic baroque sacred oil painting style, filling 100% of the square image seamlessly edge-to-edge. "
        "CRITICAL: Absolutely borderless, full-bleed, NO physical canvas edge, NO neon rings, NO photo of painting, NO picture frame, NO easel, NO wall. "
        "Close-up upper-body portrait for the Nativity of the Blessed Virgin Mary (Natividade de Nossa Senhora). "
        "Saint Anne (Santa Ana), devout and loving elderly holy mother with a soft dark veil and deep burgundy mantle, gazing with boundless maternal love and joy at her newborn baby daughter Mary. "
        "The newborn infant Virgin Mary is swaddled in pure soft white linen, sleeping peacefully in her arms. "
        "Saint Anne's hands have exactly five natural, gentle, well-rendered fingers on each hand, cradling the baby naturally and tenderly (strictly 5 fingers, NO extra thumbs or fingers). "
        "A soft, ethereal, delicate golden halo glows naturally and gently around baby Mary's head. "
        "Warm celestial golden chiaroscuro light illuminating mother and child against a deep dark background, masterpiece in the style of Bartolome Esteban Murillo and Francisco de Zurbaran."
    ),
}

NAMES = {
    (9, 11): ("Dedicação da Basílica de Latrão", "Festa"),
    (29, 6): ("Santos Pedro e Paulo", "Apóstolos"),
    (8, 9): ("Natividade de Nossa Senhora", "Festa"),
}

def main():
    client = create_client()
    for (dia, mes), prompt in PROMPTS.items():
        nome, sub = NAMES[(dia, mes)]
        log(f"\n========================================================")
        log(f"REGENERANDO COM NOVO PROMPT: {dia:02d}/{mes:02d} - {nome}")
        log(f"========================================================")
        
        final_path = os.path.join(IMAGES_DIR, f"santo_{mes:02d}_{dia:02d}.webp")
        tmp_path = os.path.join(IMAGES_DIR, f"_tmp_fix_{mes:02d}_{dia:02d}.png")
        
        for attempt in range(1, 4):
            log(f"[{dia:02d}/{mes:02d}] Tentativa {attempt}/3...")
            try:
                resp = client.models.generate_content(
                    model="gemini-3.1-flash-image",
                    contents=[prompt],
                )
                raw = None
                for part in resp.parts:
                    if part.inline_data is not None:
                        raw = part.inline_data.data
                        break
                
                if not raw:
                    log("Nenhum dado de imagem retornado.")
                    time.sleep(5)
                    continue
                
                data = raw if isinstance(raw, bytes) else base64.b64decode(raw)
                with open(tmp_path, "wb") as f:
                    f.write(data)
                
                ok = crop_letterbox_and_convert(tmp_path, final_path)
                if os.path.exists(tmp_path):
                    os.remove(tmp_path)
                
                if not ok:
                    log("Falha no pós-processamento.")
                    time.sleep(5)
                    continue
                
                vis_ok, motivo, nota = validate_image_visual(client, final_path, nome, sub)
                if vis_ok:
                    log(f"✓ APROVADO: {dia:02d}/{mes:02d} {nome} (Nota: {nota:.1f}/10) - {motivo}")
                    update_db_image_url(dia, mes)
                    break
                else:
                    log(f"✗ REPROVADO (tentativa {attempt}): Nota {nota:.1f} - {motivo}")
                    time.sleep(8)
            except Exception as e:
                log(f"Erro: {e}")
                time.sleep(8)
        
        time.sleep(4)

if __name__ == "__main__":
    main()
