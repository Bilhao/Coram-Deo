#!/usr/bin/env python3
"""
tools/regenerate_flawed_saints.py

Script para regenerar as 26 imagens identificadas com falhas anatômicas,
iconográficas ou de aspecto de tela física, com prompts canônicos ultra-específicos
garantindo arte direta 100% full-bleed, anatomia correta e fidelidade iconográfica.
"""

import os
import sys

PROJECT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if PROJECT_DIR not in sys.path:
    sys.path.insert(0, PROJECT_DIR)

import time
import base64
from typing import Dict, List, Optional
from tools.saint_image_daemon import (
    create_client,
    crop_letterbox_and_convert,
    validate_image_visual,
    update_db_image_url,
    get_all_saints_db,
    IMAGES_DIR,
    log,
    validation_log,
)

BASE_PROMPT_PREFIX = (
    "Direct digital illustration in classic baroque sacred oil painting style, "
    "filling 100% of the square image seamlessly from edge to edge. "
    "CRITICAL: Absolutely borderless, seamless full-bleed edge-to-edge, NO physical canvas edge, "
    "NO canvas texture borders, NO photo of a painting, NO picture frame, NO wooden frame, "
    "NO easel, NO museum wall background, NO white edges, NO drop shadow, strictly no text, no letters. "
)

BASE_PROMPT_SUFFIX = (
    " Delicately rendered hands with exactly five distinct, well-proportioned natural fingers on each hand. "
    "A faint, delicate translucent golden halo glowing softly above the head. "
    "Dramatic warm golden chiaroscuro lighting illuminating face and hands against a deep dark velvety background. "
    "Solemn masterwork in the style of Francisco de Zurbaran, Diego Velazquez and Caravaggio, rich oil paint textures."
)

FLAWED_SAINTS_PROMPTS = {
    (1, 1): (
        "Close-up upper-body sacred portrait of the Blessed Virgin Mary, Mother of God (Santa Maria, Mãe de Deus). "
        "Devout, youthful Queen of Heaven clothed in deep celestial blue mantle and soft crimson tunic. "
        "Holding the newborn infant Jesus reverently against her chest. "
        "Both of Mary's hands with five natural, beautifully sculpted fingers gently cradling the Child."
    ),
    (2, 1): (
        "Close-up upper-body portrait of two holy Greek Fathers and Doctors of the Church side by side: "
        "Saint Basil the Great (São Basílio Magno) with dark ascetic beard holding a closed sacred codex, and "
        "Saint Gregory Nazianzen (São Gregório Nazianzeno) with noble white beard raising his hand in blessing. "
        "Both wearing authentic 4th-century Eastern Byzantine episcopal vestments (omophorion with dark crosses). "
        "Hands with natural five fingers on each hand, serene venerable expressions."
    ),
    (11, 1): (
        "Close-up upper-body portrait of Saint Paulinus of Aquileia (São Paulino de Aquileia), 8th-century patriarch and scholar. "
        "Wearing historic Carolingian liturgical vestments with chasuble and simple pectoral cross. "
        "Venerable scholar bishop face with grey beard. "
        "Right hand with five natural fingers raised in solemn episcopal blessing, "
        "left hand with five natural fingers holding an ancient pastoral crosier."
    ),
    (29, 6): (
        "Close-up upper-body portrait of the two Princes of the Apostles side by side in sacred communion: "
        "Saint Peter (São Pedro) on the left with grey curls and beard, holding the golden keys of the kingdom with five natural fingers, and "
        "Saint Paul (São Paulo) on the right with dark beard and noble bald forehead, holding a sacred closed codex and sword hilt with five natural fingers. "
        "Ancient apostolic tunics and cloaks, profound brotherly devotion."
    ),
    (8, 9): (
        "Sacred depiction of the Nativity of the Blessed Virgin Mary (Natividade de Nossa Senhora). "
        "Saint Anne (Santa Ana), devout elderly holy mother wearing a modest veil, cradling with immense tenderness "
        "her newborn baby daughter Mary wrapped in pure white swaddling cloths. "
        "Saint Anne's hands with five natural gentle fingers holding the infant. "
        "A soft celestial glow emanates from baby Mary's head."
    ),
    (9, 9): (
        "Close-up upper-body portrait of Saint Peter Claver (São Pedro Claver), 17th-century Jesuit missionary priest and slave of the slaves. "
        "Wearing simple worn black Jesuit cassock. Devout, profoundly compassionate bearded face. "
        "Right hand with five natural fingers gently holding a plain wooden crucifix against his heart, "
        "left hand with five natural fingers resting on his chest in loving contemplation."
    ),
    (11, 9): (
        "Close-up upper-body portrait of Saint Paphnutius (São Pafnúncio), 4th-century Egyptian desert monk and bishop of the Thebaid. "
        "Ascetic venerable countenance with noble white beard. "
        "Wearing humble desert monk tunic and simple mantle. "
        "Right hand with five natural fingers raised in blessing, "
        "left hand with five natural fingers resting reverently upon a leather-bound book of the Gospels (NO text, NO letters on book)."
    ),
    (12, 9): (
        "Close-up upper-body portrait for the Most Holy Name of Mary (Santíssimo Nome de Maria). "
        "The Blessed Virgin Mary, young, radiant with holy grace and purity, wearing a delicate veil and soft sky-blue mantle. "
        "Her hands folded reverently over her chest in humble prayer, showing five distinct, gracefully proportioned natural fingers on each hand. "
        "Eyes lowered with supreme sweetness and humility."
    ),
    (13, 9): (
        "Close-up upper-body portrait of Saint John Chrysostom (São João Crisóstomo - Golden Mouth), 4th-century Archbishop of Constantinople and Doctor of the Church. "
        "Ascetic, brilliant scholarly countenance with trimmed beard. "
        "Wearing authentic Eastern Byzantine episcopal vestments (phelonion and omophorion with black crosses). "
        "Right hand with five natural fingers raised in teaching/blessing, left hand with five natural fingers holding an ancient codex of homilies."
    ),
    (5, 10): (
        "Close-up upper-body portrait of Saint Faustina Kowalska (Santa Faustina), 20th-century Polish nun and apostle of Divine Mercy. "
        "Wearing the authentic black habit and white wimple of the Sisters of Our Lady of Mercy. "
        "Young, humble, serene face glowing with holy trust and divine peace. "
        "Hands with five natural, well-rendered fingers folded gently in prayer. "
        "Subtle faint red and pale rays of Divine Mercy glowing softly in the background behind her."
    ),
    (11, 10): (
        "Close-up upper-body portrait of Pope Saint John XXIII (São João XXIII), 20th-century Pope (Angelo Roncalli). "
        "Kindly, smiling, benevolent round face of the Good Pope (clean-shaven, NO long beard). "
        "Wearing authentic white papal cassock, white zucchetto, and red liturgical mozzetta with golden pectoral cross. "
        "Right hand with five natural fingers raised in fatherly blessing."
    ),
    (19, 10): (
        "Close-up upper-body portrait of Saint John de Brébeuf (São João de Brébeuf), Jesuit missionary and martyr in North America. "
        "Wearing heavy black Jesuit cassock and winter travel cloak. "
        "Courageous, resolute heroic face with dark beard. "
        "Right hand with five natural fingers holding a missionary wooden cross, "
        "left hand with five natural fingers holding a green palm branch of martyrdom."
    ),
    (20, 10): (
        "Close-up upper-body portrait of Saint John Cantius (São João Câncio), 15th-century priest and university professor of theology. "
        "Wearing simple academic canon cassock and clerical collar. "
        "Devout scholar face with gentle compassionate eyes and grey hair. "
        "Right hand with five natural fingers giving bread to the invisible poor, "
        "left hand with five natural fingers holding a closed theological codex."
    ),
    (21, 10): (
        "Close-up upper-body portrait of Saint Ursula (Santa Úrsula), 4th-century Christian princess and virgin martyr. "
        "Beautiful young noble maiden (NOT an old man) wearing deep red velvet gown with delicate royal ermine trim and a small golden crown. "
        "Right hand with five natural fingers holding a white banner of Christ's victory, "
        "left hand with five natural fingers holding a green palm of martyrdom close to her heart."
    ),
    (22, 10): (
        "Close-up upper-body portrait of Pope Saint John Paul II (São João Paulo II, Karol Wojtyła). "
        "Authentic historic appearance of the beloved modern Pope: clean-shaven, dignified noble Polish features (NO beard). "
        "Wearing traditional white papal cassock, white papal zucchetto (calota), and golden pectoral cross. "
        "Right hand with five natural fingers raised in blessing, left hand resting over his heart in deep Marian prayer."
    ),
    (23, 10): (
        "Close-up upper-body portrait of Saint John of Capistrano (São João de Capistrano), 15th-century Franciscan friar and preacher. "
        "Wearing brown Franciscan habit with cord cincture. Intense, fervent, ascetic bearded face. "
        "Right hand with five natural fingers holding a crucifix banner aloft, "
        "left hand with five natural fingers resting on his chest in fiery devotion."
    ),
    (24, 10): (
        "Close-up upper-body portrait of Saint Anthony Mary Claret (Santo Antônio Maria Claret), 19th-century missionary archbishop and founder of the Claretians. "
        "Wearing black clerical cassock and pectoral cross. Fervent, kind pastoral face with short grey hair and beard. "
        "Right hand with five natural fingers pointing to the Immaculate Heart of Mary, "
        "left hand with five natural fingers holding a closed Bible."
    ),
    (26, 10): (
        "Close-up upper-body portrait of Pope Saint Evaristus (Santo Evaristo, Papa), 1st-century Pope and martyr. "
        "Ancient venerable bishop face with white beard. "
        "Wearing ancient simple liturgical pallium over white tunic. "
        "Right hand with five natural fingers raised in blessing, "
        "left hand with five natural fingers holding an anchor and olive branch."
    ),
    (30, 10): (
        "Close-up upper-body portrait of Saint Marcellus of Tangier (São Marcelo de Tânger), 3rd-century Christian centurion and martyr. "
        "Noble Roman centurion face with short hair. "
        "Wearing authentic Roman military breastplate (lorica) over red tunic, having laid down his sword and vine staff. "
        "Both hands with five natural fingers held up in open prayer professing allegiance to Christ alone."
    ),
    (31, 10): (
        "Close-up upper-body portrait of Saint Alphonsus Rodriguez (Santo Afonso Rodrigues), 16th-17th century humble Jesuit lay brother and porter (NOT a bishop, NO miter, NO pastoral staff). "
        "Wearing simple, humble black Jesuit cassock with no decorations. "
        "Gentle, holy elderly face with white hair and beard, beaming with supernatural charity. "
        "Hands with five natural fingers holding keys of the college gate and a wooden rosary in prayer."
    ),
    (7, 11): (
        "Close-up upper-body portrait of Saint Willibrord (São Vilibrordo), 8th-century Anglo-Saxon missionary bishop and Apostle of the Frisians. "
        "Venerable elder bishop with white hair and beard. "
        "Wearing simple medieval bishop chasuble and pallium. "
        "Right hand with five natural fingers holding an episcopal pastoral crosier, "
        "left hand with five natural fingers holding a closed leather-bound Book of the Gospels."
    ),
    (8, 11): (
        "Close-up upper-body portrait of Blessed John Duns Scotus (Beato João Duns Escoto), 13th-century Franciscan philosopher and theologian (Doctor Subtilis). "
        "Wearing brown Franciscan habit with cowl hood and white cord. "
        "Keen scholarly contemplative face with trimmed beard. "
        "Right hand with five natural fingers holding a quill pen, "
        "left hand with five natural fingers resting reverently upon a theological manuscript."
    ),
    (9, 11): (
        "Sacred depiction for the Feast of the Dedication of the Lateran Archbasilica (Dedicação da Basílica de São João de Latrão - Omnium Urbis et Orbis Ecclesiarum Mater et Caput). "
        "Pope Saint Sylvester I in ancient papal liturgical vestments, holding with both hands with natural five fingers "
        "a delicate miniature architectural model of the Lateran Archbasilica with its monumental Classical colonnaded portico facade and roof statues (NOT Saint Peter's dome). "
        "Venerable elder countenance, profound reverent expression."
    ),
    (24, 11): (
        "Close-up upper-body portrait of Saint Andrew Dung-Lac (Santo André Dung-Lac), 19th-century Vietnamese priest and martyr. "
        "Dignified Vietnamese clerical tunic with red stole of martyrdom. "
        "Serene, courageous Asian face glowing with steadfast faith. "
        "Right hand with five natural fingers gently holding a plain wooden crucifix, "
        "left hand with five natural fingers holding a green palm branch of martyrdom."
    ),
    (26, 11): (
        "Close-up upper-body portrait of Saint Leonard of Port Maurice (São Leonardo de Porto Maurício), 18th-century Franciscan preacher and apostle of the Stations of the Cross. "
        "Wearing brown Franciscan habit with cord cincture. "
        "Ardent, devout bearded face gazing lovingly upon the Crucified Lord. "
        "Both hands with five natural well-rendered fingers holding a wooden crucifix reverently against his chest."
    ),
    (30, 11): (
        "Close-up upper-body portrait of Saint Andrew the Apostle (Santo André Apóstolo), brother of Peter, Apostle and martyr. "
        "Venerable elder fisherman apostle with white hair and beard. "
        "Right hand with five natural fingers and left hand with five natural fingers reverently embracing "
        "the large diagonal timber cross in X-shape (Saint Andrew's Cross) with deep love for his Lord."
    ),
}


def build_saint_custom_prompt(dia: int, mes: int) -> str:
    custom_desc = FLAWED_SAINTS_PROMPTS.get((dia, mes))
    if not custom_desc:
        raise ValueError(f"Prompt não configurado para {dia:02d}/{mes:02d}")
    return f"{BASE_PROMPT_PREFIX}{custom_desc}{BASE_PROMPT_SUFFIX}"


def regenerate_saint(client, dia: int, mes: int, saint_dict: Dict) -> bool:
    nome = saint_dict["nome"]
    subtitulo = saint_dict.get("subtitulo", "")
    final_path = os.path.join(IMAGES_DIR, f"santo_{mes:02d}_{dia:02d}.webp")
    tmp_path = os.path.join(IMAGES_DIR, f"_tmp_regen_{mes:02d}_{dia:02d}.png")

    prompt = build_saint_custom_prompt(dia, mes)
    log(f"============================================================")
    log(f"REGENERANDO: {dia:02d}/{mes:02d} - {nome}")
    log(f"============================================================")

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
                log(f"Nenhum dado de imagem retornado (tentativa {attempt}).")
                time.sleep(5)
                continue

            data = raw if isinstance(raw, bytes) else base64.b64decode(raw)
            with open(tmp_path, "wb") as f:
                f.write(data)

            # Crop letterbox & convert to 1024x1024 WebP
            ok = crop_letterbox_and_convert(tmp_path, final_path)
            try:
                if os.path.exists(tmp_path):
                    os.remove(tmp_path)
            except Exception:
                pass

            if not ok:
                log(f"Falha no pós-processamento (tentativa {attempt}).")
                time.sleep(5)
                continue

            # Validação visual por IA
            vis_ok, motivo, nota = validate_image_visual(client, final_path, nome, subtitulo)
            if vis_ok:
                log(f"✓ APROVADO: {dia:02d}/{mes:02d} {nome} (Nota: {nota:.1f}/10) - {motivo}")
                update_db_image_url(dia, mes)
                return True
            else:
                log(f"✗ REPROVADO (tentativa {attempt}): Nota {nota:.1f} - {motivo}")
                time.sleep(8)

        except Exception as e:
            log(f"Erro na tentativa {attempt}: {e}")
            time.sleep(8)

    log(f"❌ Falha após 3 tentativas para {dia:02d}/{mes:02d} {nome}")
    return False


def main():
    client = create_client()
    all_saints = get_all_saints_db()
    saints_map = { (s["dia"], s["mes"]): s for s in all_saints }

    targets = sorted(FLAWED_SAINTS_PROMPTS.keys(), key=lambda x: (x[1], x[0]))
    total = len(targets)
    log(f"Iniciando regeneração cirúrgica de {total} imagens com problemas...")

    successes = 0
    failures = []

    for idx, (dia, mes) in enumerate(targets, 1):
        s = saints_map.get((dia, mes))
        if not s:
            log(f"Santo {dia}/{mes} não encontrado no BD!")
            continue

        log(f"\n[{idx}/{total}] Processando {dia:02d}/{mes:02d} - {s['nome']}...")
        ok = regenerate_saint(client, dia, mes, s)
        if ok:
            successes += 1
        else:
            failures.append((dia, mes, s["nome"]))

        # Cooldown suave entre santos para respeitar rate limit
        time.sleep(4)

    log("\n" + "=" * 60)
    log(f"RELATÓRIO FINAL DE REGENERAÇÃO CIRÚRGICA")
    log(f"Total alvos: {total}")
    log(f"Sucessos: {successes}/{total}")
    log(f"Falhas: {len(failures)}")
    if failures:
        for d, m, nome in failures:
            log(f"  - {d:02d}/{m:02d} {nome}")
    log("=" * 60)


if __name__ == "__main__":
    main()
