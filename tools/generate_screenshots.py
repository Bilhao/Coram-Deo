#!/usr/bin/env python3
"""
Coram Deo — Gerador de Screenshots Profissionais para Google Play Store
Dimensão oficial: 1080 x 1920 (proporção 9:16)
Renderiza molduras 3D de alta fidelidade, suporte a telas individuais e duplas (Light/Dark),
além da tela vetorial de alta definição para Backup & Segurança na Nuvem.
"""

import os
import argparse
from PIL import Image, ImageDraw, ImageFont, ImageFilter

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
RAW_DIR = os.path.join(BASE_DIR, "screenshots", "raw")
OUTPUT_PT_DIR = os.path.join(BASE_DIR, "screenshots", "output", "pt-BR")
OUTPUT_EN_DIR = os.path.join(BASE_DIR, "screenshots", "output", "en-US")

os.makedirs(RAW_DIR, exist_ok=True)
os.makedirs(OUTPUT_PT_DIR, exist_ok=True)
os.makedirs(OUTPUT_EN_DIR, exist_ok=True)

CANVAS_WIDTH = 1080
CANVAS_HEIGHT = 1920

# Paleta Nobre Coram Deo
COLOR_BG_TOP = (5, 18, 38)        # Azul Noturno Litúrgico (#051226)
COLOR_BG_BOTTOM = (10, 32, 60)    # Azul Nobre Escuro (#0A203C)
COLOR_GOLD = (218, 178, 100)      # Ouro Litúrgico (#DAB264)
COLOR_WHITE = (255, 255, 255)
COLOR_SUBTITLE = (175, 196, 220)  # Azul Acinzentado Claro
COLOR_FRAME_OUTER = (30, 38, 50)  # Titânio escuro
COLOR_FRAME_BORDER = (55, 70, 90) # Reflexo de borda metálica
COLOR_FRAME_INNER = (10, 14, 20)  # Bisel interno

# Fontes
FONT_BOLD_PATH = "/usr/share/fonts/noto/NotoSans-Bold.ttf"
FONT_REGULAR_PATH = "/usr/share/fonts/noto/NotoSans-Regular.ttf"

try:
    font_badge = ImageFont.truetype(FONT_BOLD_PATH, 28)
    font_title = ImageFont.truetype(FONT_BOLD_PATH, 54)
    font_subtitle = ImageFont.truetype(FONT_REGULAR_PATH, 34)
except Exception:
    font_badge = ImageFont.load_default()
    font_title = ImageFont.load_default()
    font_subtitle = ImageFont.load_default()

def create_background():
    base = Image.new("RGB", (CANVAS_WIDTH, CANVAS_HEIGHT), COLOR_BG_TOP)
    draw = ImageDraw.Draw(base)
    
    # Gradiente suave vertical
    for y in range(CANVAS_HEIGHT):
        factor = y / float(CANVAS_HEIGHT)
        r = int(COLOR_BG_TOP[0] + (COLOR_BG_BOTTOM[0] - COLOR_BG_TOP[0]) * factor)
        g = int(COLOR_BG_TOP[1] + (COLOR_BG_BOTTOM[1] - COLOR_BG_TOP[1]) * factor)
        b = int(COLOR_BG_TOP[2] + (COLOR_BG_BOTTOM[2] - COLOR_BG_TOP[2]) * factor)
        draw.line([(0, y), (CANVAS_WIDTH, y)], fill=(r, g, b))
        
    # Halo de iluminação celeste no topo
    halo = Image.new("RGBA", (CANVAS_WIDTH, CANVAS_HEIGHT), (0, 0, 0, 0))
    halo_draw = ImageDraw.Draw(halo)
    cx, cy = CANVAS_WIDTH // 2, 280
    for rad in range(550, 40, -30):
        alpha = int(8 * (1.0 - (rad / 550.0)))
        halo_draw.ellipse([cx - rad, cy - rad, cx + rad, cy + rad], fill=(218, 178, 100, alpha))
        
    return Image.alpha_composite(base.convert("RGBA"), halo).convert("RGB")

def render_banner(raw_path, badge, title, subtitle, output_path):
    canvas = create_background()
    draw = ImageDraw.Draw(canvas)
    
    # 1. Badge Superior
    badge_text = badge.upper()
    bb = draw.textbbox((0, 0), badge_text, font=font_badge)
    bw = bb[2] - bb[0]
    draw.text(((CANVAS_WIDTH - bw) // 2, 125), badge_text, font=font_badge, fill=COLOR_GOLD)
    
    # 2. Título Principal
    tb = draw.textbbox((0, 0), title, font=font_title)
    tw = tb[2] - tb[0]
    draw.text(((CANVAS_WIDTH - tw) // 2, 175), title, font=font_title, fill=COLOR_WHITE)
    
    # 3. Subtítulo
    sb = draw.textbbox((0, 0), subtitle, font=font_subtitle)
    sw = sb[2] - sb[0]
    draw.text(((CANVAS_WIDTH - sw) // 2, 255), subtitle, font=font_subtitle, fill=COLOR_SUBTITLE)
    
    # 4. Mockup do Smartphone (Estilo Moderno Flagship)
    phone_w = 780
    phone_h = 1530
    phone_x = (CANVAS_WIDTH - phone_w) // 2
    phone_y = 360
    corner_radius = 52
    bezel_thickness = 14
    
    # 5. Sombra suave (Drop shadow)
    shadow = Image.new("RGBA", (CANVAS_WIDTH, CANVAS_HEIGHT), (0, 0, 0, 0))
    s_draw = ImageDraw.Draw(shadow)
    s_draw.rounded_rectangle(
        [phone_x + 12, phone_y + 30, phone_x + phone_w - 12, phone_y + phone_h + 35],
        radius=corner_radius + 4,
        fill=(0, 0, 0, 160)
    )
    shadow = shadow.filter(ImageFilter.GaussianBlur(radius=36))
    
    canvas_rgba = Image.alpha_composite(canvas.convert("RGBA"), shadow)
    
    # 6. Camada do Dispositivo
    device_layer = Image.new("RGBA", (CANVAS_WIDTH, CANVAS_HEIGHT), (0, 0, 0, 0))
    d_draw = ImageDraw.Draw(device_layer)
    
    # Moldura de titânio externa
    d_draw.rounded_rectangle(
        [phone_x, phone_y, phone_x + phone_w, phone_y + phone_h],
        radius=corner_radius,
        fill=COLOR_FRAME_OUTER,
        outline=COLOR_FRAME_BORDER,
        width=2
    )
    
    # Área interna da tela
    screen_x = phone_x + bezel_thickness
    screen_y = phone_y + bezel_thickness
    screen_w = phone_w - (2 * bezel_thickness)
    screen_h = phone_h - (2 * bezel_thickness)
    screen_radius = corner_radius - 12
    
    if os.path.exists(raw_path):
        screen_raw = Image.open(raw_path).convert("RGBA")
        screen_scaled = screen_raw.resize((screen_w, screen_h), Image.Resampling.LANCZOS)
        
        mask = Image.new("L", (screen_w, screen_h), 0)
        m_draw = ImageDraw.Draw(mask)
        m_draw.rounded_rectangle([0, 0, screen_w, screen_h], radius=screen_radius, fill=255)
        
        device_layer.paste(screen_scaled, (screen_x, screen_y), mask)
    else:
        d_draw.rounded_rectangle(
            [screen_x, screen_y, screen_x + screen_w, screen_y + screen_h],
            radius=screen_radius,
            fill=(14, 18, 26)
        )
        
    # Câmera frontal discreta (Punch hole / Dynamic pill)
    cam_w = 90
    cam_h = 24
    cam_x = phone_x + (phone_w - cam_w) // 2
    cam_y = phone_y + bezel_thickness + 12
    d_draw.rounded_rectangle([cam_x, cam_y, cam_x + cam_w, cam_y + cam_h], radius=12, fill=(6, 8, 12))
    
    final_img = Image.alpha_composite(canvas_rgba, device_layer).convert("RGB")
    final_img.save(output_path, "PNG", quality=95)
    print(f"  ✓ {os.path.basename(output_path)}")

def render_dual_banner(light_raw, dark_raw, badge, title, subtitle, output_path):
    canvas = create_background()
    draw = ImageDraw.Draw(canvas)
    
    # 1. Badge Superior
    badge_text = badge.upper()
    bb = draw.textbbox((0, 0), badge_text, font=font_badge)
    bw = bb[2] - bb[0]
    draw.text(((CANVAS_WIDTH - bw) // 2, 125), badge_text, font=font_badge, fill=COLOR_GOLD)
    
    # 2. Título Principal
    tb = draw.textbbox((0, 0), title, font=font_title)
    tw = tb[2] - tb[0]
    draw.text(((CANVAS_WIDTH - tw) // 2, 175), title, font=font_title, fill=COLOR_WHITE)
    
    # 3. Subtítulo
    sb = draw.textbbox((0, 0), subtitle, font=font_subtitle)
    sw = sb[2] - sb[0]
    draw.text(((CANVAS_WIDTH - sw) // 2, 255), subtitle, font=font_subtitle, fill=COLOR_SUBTITLE)
    
    # Função auxiliar para criar cada smartphone em escala
    def make_phone(screen_img_path, scale=0.76):
        pw = int(750 * scale)
        ph = int(1500 * scale)
        corner = int(52 * scale)
        bezel = int(14 * scale)
        pad = 30
        
        phone = Image.new("RGBA", (pw + 2*pad, ph + 2*pad), (0, 0, 0, 0))
        p_draw = ImageDraw.Draw(phone)
        
        p_draw.rounded_rectangle([pad, pad, pad + pw, pad + ph], radius=corner, fill=COLOR_FRAME_OUTER, outline=COLOR_FRAME_BORDER, width=2)
        
        sw = pw - (2 * bezel)
        sh = ph - (2 * bezel)
        raw = Image.open(screen_img_path).convert("RGBA")
        scaled = raw.resize((sw, sh), Image.Resampling.LANCZOS)
        
        s_mask = Image.new("L", (sw, sh), 0)
        m_draw = ImageDraw.Draw(s_mask)
        m_draw.rounded_rectangle([0, 0, sw, sh], radius=corner - 10, fill=255)
        
        phone.paste(scaled, (pad + bezel, pad + bezel), s_mask)
        
        cw = int(88 * scale)
        ch = int(22 * scale)
        p_draw.rounded_rectangle([pad + (pw - cw) // 2, pad + bezel + 10, pad + (pw + cw) // 2, pad + bezel + 10 + ch], radius=ch//2, fill=(6, 8, 12))
        
        return phone, pw, ph, pad

    phone_light, pw, ph, pad = make_phone(light_raw, scale=0.76)
    phone_dark, _, _, _ = make_phone(dark_raw, scale=0.76)
    
    canvas_rgba = canvas.convert("RGBA")
    
    # Smartphone Tema Claro: à esquerda e ligeiramente ao fundo
    lx = 60
    ly = 400
    sh_light = Image.new("RGBA", (CANVAS_WIDTH, CANVAS_HEIGHT), (0, 0, 0, 0))
    sh_draw = ImageDraw.Draw(sh_light)
    sh_draw.rounded_rectangle([lx + pad + 10, ly + pad + 25, lx + pad + pw - 10, ly + pad + ph + 30], radius=45, fill=(0, 0, 0, 160))
    sh_light = sh_light.filter(ImageFilter.GaussianBlur(radius=30))
    canvas_rgba = Image.alpha_composite(canvas_rgba, sh_light)
    canvas_rgba.paste(phone_light, (lx, ly), phone_light)
    
    # Smartphone Tema Escuro: à direita, em primeiro plano (drop shadow sobreposto)
    dx = CANVAS_WIDTH - pw - 2*pad - 60
    dy = 475
    sh_dark = Image.new("RGBA", (CANVAS_WIDTH, CANVAS_HEIGHT), (0, 0, 0, 0))
    sh_draw2 = ImageDraw.Draw(sh_dark)
    sh_draw2.rounded_rectangle([dx + pad + 10, dy + pad + 25, dx + pad + pw - 10, dy + pad + ph + 30], radius=45, fill=(0, 0, 0, 210))
    sh_dark = sh_dark.filter(ImageFilter.GaussianBlur(radius=35))
    canvas_rgba = Image.alpha_composite(canvas_rgba, sh_dark)
    canvas_rgba.paste(phone_dark, (dx, dy), phone_dark)
    
    final_img = canvas_rgba.convert("RGB")
    final_img.save(output_path, "PNG", quality=95)
    print(f"  ✓ {os.path.basename(output_path)}")

def generate_vector_backup_screens():
    """Renderiza telas vetoriais nativas em alta resolução (1220x2712) para Backup em PT e EN."""
    W = 1220
    H = 2712

    f_appbar = ImageFont.truetype(FONT_BOLD_PATH, 52)
    f_h2 = ImageFont.truetype(FONT_BOLD_PATH, 46)
    f_h3 = ImageFont.truetype(FONT_BOLD_PATH, 36)
    f_body = ImageFont.truetype(FONT_REGULAR_PATH, 30)
    f_small = ImageFont.truetype(FONT_REGULAR_PATH, 26)
    f_badge = ImageFont.truetype(FONT_BOLD_PATH, 26)
    f_btn = ImageFont.truetype(FONT_BOLD_PATH, 34)

    configs = [
        {
            "lang": "pt",
            "file": "screen_backup_pt.png",
            "appbar": "Backup e Segurança",
            "hero_t": "Seus Dados Seguros na Nuvem",
            "hero_s": "Histórico de orações e hábitos preservados",
            "acc_t": "Conta Google Vinculada",
            "acc_s": "Sincronização em nuvem ativa",
            "acc_b": "Conectado",
            "auto_t": "Backup Automático Diário",
            "auto_s": "Salva seus dados 1x ao dia ao abrir o app",
            "sync_t": "Último backup realizado",
            "sync_s": "Hoje às 12:00 • 100% atualizado na nuvem",
            "btn1": "Fazer Backup",
            "btn2": "Restaurar",
            "sec_t": "Privacidade & Proteção de Dados",
            "bullets": [
                "Seus registros de oração pertencem unicamente a você",
                "Criptografia na transmissão e armazenamento seguro",
                "Troque de aparelho sem nunca perder seu progresso",
                "100% livre de anúncios, rastreadores ou monetização de dados"
            ]
        },
        {
            "lang": "en",
            "file": "screen_backup_en.png",
            "appbar": "Backup & Security",
            "hero_t": "Your Data Secured in the Cloud",
            "hero_s": "Prayer history and spiritual habits preserved",
            "acc_t": "Linked Google Account",
            "acc_s": "Cloud synchronization active",
            "acc_b": "Connected",
            "auto_t": "Automatic Daily Backup",
            "auto_s": "Syncs your data once daily when opening app",
            "sync_t": "Latest cloud backup",
            "sync_s": "Today at 12:00 • 100% up to date in cloud",
            "btn1": "Back Up Now",
            "btn2": "Restore",
            "sec_t": "Privacy & Data Protection",
            "bullets": [
                "Your prayer records belong exclusively to you",
                "End-to-end encryption in transit and secure storage",
                "Switch devices seamlessly without losing your progress",
                "100% ad-free with zero trackers or data monetization"
            ]
        }
    ]

    for cfg in configs:
        target_path = os.path.join(RAW_DIR, cfg["file"])
        img = Image.new("RGBA", (W, H), (16, 22, 32))
        draw = ImageDraw.Draw(img)

        # Gradiente de fundo da tela do app
        for y in range(H):
            factor = y / float(H)
            r = int(17 - 5 * factor)
            g = int(24 - 7 * factor)
            b = int(36 - 10 * factor)
            draw.line([(0, y), (W, y)], fill=(r, g, b))

        # Barra de status do sistema
        draw.text((70, 45), "16:00", font=f_badge, fill=(255, 255, 255, 230))
        for i in range(4):
            bx = W - 220 + i * 14
            by = 75 - (i + 1) * 7
            draw.rounded_rectangle([bx, by, bx + 9, 75], radius=2, fill=(255, 255, 255, 230))
        draw.arc([W - 150, 48, W - 120, 78], start=210, end=330, fill=(255, 255, 255, 230), width=3)
        draw.arc([W - 145, 54, W - 125, 74], start=210, end=330, fill=(255, 255, 255, 230), width=3)
        draw.ellipse([W - 137, 68, W - 133, 72], fill=(255, 255, 255, 230))
        draw.rounded_rectangle([W - 100, 50, W - 60, 73], radius=4, outline=(255, 255, 255, 230), width=2)
        draw.rectangle([W - 96, 54, W - 66, 69], fill=(74, 222, 128))
        draw.rectangle([W - 59, 57, W - 56, 66], fill=(255, 255, 255, 230))

        # AppBar com seta de voltar
        draw.line([(85, 148), (115, 148)], fill=(255, 255, 255), width=5)
        draw.line([(85, 148), (98, 135)], fill=(255, 255, 255), width=5)
        draw.line([(85, 148), (98, 161)], fill=(255, 255, 255), width=5)
        draw.text((150, 122), cfg["appbar"], font=f_appbar, fill=(255, 255, 255))

        # Card de Destaque Superior (Hero)
        hero_y1 = 240
        hero_y2 = 780
        draw.rounded_rectangle([65, hero_y1, W - 65, hero_y2], radius=44, fill=(22, 32, 48), outline=(42, 60, 88), width=2)

        cx = W // 2
        cy = hero_y1 + 200
        r_circle = 110

        halo = Image.new("RGBA", (W, H), (0, 0, 0, 0))
        h_draw = ImageDraw.Draw(halo)
        for r in range(160, 100, -10):
            a = int(30 * (1.0 - (r - 100) / 60.0))
            h_draw.ellipse([cx - r, cy - r, cx + r, cy + r], fill=(218, 178, 100, a))
        img = Image.alpha_composite(img, halo)
        draw = ImageDraw.Draw(img)

        draw.ellipse([cx - r_circle, cy - r_circle, cx + r_circle, cy + r_circle], fill=(16, 36, 64), outline=(218, 178, 100), width=4)

        # Nuvem estilizada com check
        def draw_cloud(draw_obj, ox, oy, scale=1.0, color=(218, 178, 100)):
            draw_obj.ellipse([ox - 45*scale, oy - 15*scale, ox + 15*scale, oy + 35*scale], fill=color)
            draw_obj.ellipse([ox - 20*scale, oy - 45*scale, ox + 40*scale, oy + 25*scale], fill=color)
            draw_obj.ellipse([ox + 10*scale, oy - 25*scale, ox + 60*scale, oy + 35*scale], fill=color)
            draw_obj.rounded_rectangle([ox - 40*scale, oy + 5*scale, ox + 55*scale, oy + 35*scale], radius=int(12*scale), fill=color)

        draw_cloud(draw, cx, cy - 10, scale=1.3, color=(218, 178, 100))
        draw.line([(cx - 15, cy + 2), (cx + 5, cy + 22)], fill=(74, 222, 128), width=6)
        draw.line([(cx + 5, cy + 22), (cx + 35, cy - 14)], fill=(74, 222, 128), width=6)

        bb = draw.textbbox((0, 0), cfg["hero_t"], font=f_h2)
        draw.text((cx - (bb[2] - bb[0]) // 2, cy + 140), cfg["hero_t"], font=f_h2, fill=(255, 255, 255))

        bb = draw.textbbox((0, 0), cfg["hero_s"], font=f_body)
        draw.text((cx - (bb[2] - bb[0]) // 2, cy + 215), cfg["hero_s"], font=f_body, fill=(160, 185, 215))

        # Card de Status de Sincronização
        card_y1 = 830
        card_y2 = 1430
        draw.rounded_rectangle([65, card_y1, W - 65, card_y2], radius=40, fill=(22, 30, 44), outline=(38, 52, 74), width=2)

        # Linha 1: Google Account
        gx, gy = 135, card_y1 + 75
        draw.ellipse([gx - 32, gy - 32, gx + 32, gy + 32], fill=(255, 255, 255))
        draw.text((gx - 16, gy - 26), "G", font=ImageFont.truetype(FONT_BOLD_PATH, 38), fill=(66, 133, 244))

        draw.text((195, card_y1 + 45), cfg["acc_t"], font=f_h3, fill=(255, 255, 255))
        draw.text((195, card_y1 + 95), cfg["acc_s"], font=f_small, fill=(145, 168, 195))

        pill_x1 = W - 320
        pill_y1 = card_y1 + 55
        pill_x2 = W - 115
        pill_y2 = card_y1 + 115
        draw.rounded_rectangle([pill_x1, pill_y1, pill_x2, pill_y2], radius=30, fill=(27, 77, 62))
        draw.ellipse([pill_x1 + 30, pill_y1 + 22, pill_x1 + 44, pill_y1 + 36], fill=(74, 222, 128))
        draw.text((pill_x1 + 55, pill_y1 + 14), cfg["acc_b"], font=f_badge, fill=(74, 222, 128))

        draw.line([(100, card_y1 + 175), (W - 100, card_y1 + 175)], fill=(38, 52, 74), width=2)

        # Linha 2: Backup Automático
        sx, sy = 135, card_y1 + 250
        draw.arc([sx - 24, sy - 24, sx + 24, sy + 24], start=30, end=190, fill=(218, 178, 100), width=4)
        draw.polygon([(sx + 18, sy + 10), (sx + 32, sy + 18), (sx + 26, sy - 2)], fill=(218, 178, 100))
        draw.arc([sx - 24, sy - 24, sx + 24, sy + 24], start=210, end=370, fill=(218, 178, 100), width=4)
        draw.polygon([(sx - 18, sy - 10), (sx - 32, sy - 18), (sx - 26, sy + 2)], fill=(218, 178, 100))

        draw.text((195, card_y1 + 215), cfg["auto_t"], font=f_h3, fill=(255, 255, 255))
        draw.text((195, card_y1 + 270), cfg["auto_s"], font=f_small, fill=(145, 168, 195))

        sw_x = W - 235
        sw_y = card_y1 + 230
        draw.rounded_rectangle([sw_x, sw_y, sw_x + 110, sw_y + 60], radius=30, fill=(37, 99, 235))
        draw.ellipse([sw_x + 55, sw_y + 5, sw_x + 105, sw_y + 55], fill=(255, 255, 255))

        draw.line([(100, card_y1 + 355), (W - 100, card_y1 + 355)], fill=(38, 52, 74), width=2)

        # Linha 3: Último Backup
        cx3, cy3 = 135, card_y1 + 430
        draw.ellipse([cx3 - 24, cy3 - 24, cx3 + 24, cy3 + 24], outline=(160, 185, 215), width=4)
        draw.line([(cx3, cy3), (cx3, cy3 - 14)], fill=(160, 185, 215), width=4)
        draw.line([(cx3, cy3), (cx3 + 12, cy3)], fill=(160, 185, 215), width=4)

        draw.text((195, card_y1 + 395), cfg["sync_t"], font=f_h3, fill=(255, 255, 255))
        draw.text((195, card_y1 + 450), cfg["sync_s"], font=f_small, fill=(74, 222, 128))

        draw.line([(W - 180, card_y1 + 435), (W - 165, card_y1 + 452)], fill=(74, 222, 128), width=5)
        draw.line([(W - 165, card_y1 + 452), (W - 140, card_y1 + 420)], fill=(74, 222, 128), width=5)

        # Botões de Ação
        btn_y = 1480
        btn_w = (W - 130 - 30) // 2

        draw.rounded_rectangle([65, btn_y, 65 + btn_w, btn_y + 110], radius=32, fill=(37, 99, 235))
        draw_cloud(draw, 140, btn_y + 50, scale=0.6, color=(255, 255, 255))
        draw.line([(140, btn_y + 68), (140, btn_y + 44)], fill=(37, 99, 235), width=4)
        draw.line([(133, btn_y + 52), (140, btn_y + 44)], fill=(37, 99, 235), width=4)
        draw.line([(147, btn_y + 52), (140, btn_y + 44)], fill=(37, 99, 235), width=4)
        draw.text((185, btn_y + 32), cfg["btn1"], font=f_btn, fill=(255, 255, 255))

        draw.rounded_rectangle([65 + btn_w + 30, btn_y, W - 65, btn_y + 110], radius=32, fill=(18, 26, 38), outline=(60, 85, 125), width=3)
        draw_cloud(draw, 65 + btn_w + 115, btn_y + 50, scale=0.6, color=(218, 178, 100))
        draw.text((65 + btn_w + 160, btn_y + 32), cfg["btn2"], font=f_btn, fill=(218, 178, 100))

        # Card de Garantia de Privacidade
        sec_y1 = 1650
        sec_y2 = 2150
        draw.rounded_rectangle([65, sec_y1, W - 65, sec_y2], radius=40, fill=(18, 26, 38), outline=(36, 50, 72), width=2)

        sh_x, sh_y = 135, sec_y1 + 80
        draw.polygon([(sh_x, sh_y - 30), (sh_x + 28, sh_y - 18), (sh_x + 28, sh_y + 10), (sh_x, sh_y + 32), (sh_x - 28, sh_y + 10), (sh_x - 28, sh_y - 18)], fill=(218, 178, 100))
        draw.line([(sh_x - 10, sh_y), (sh_x, sh_y + 12)], fill=(18, 26, 38), width=5)
        draw.line([(sh_x, sh_y + 12), (sh_x + 14, sh_y - 8)], fill=(18, 26, 38), width=5)

        draw.text((195, sec_y1 + 60), cfg["sec_t"], font=f_h3, fill=(255, 255, 255))

        for idx, b_text in enumerate(cfg["bullets"]):
            by = sec_y1 + 160 + idx * 70
            draw.ellipse([125, by + 10, 137, by + 22], fill=(218, 178, 100))
            draw.text((160, by), b_text, font=f_body, fill=(175, 200, 230))

        img.save(target_path)

# Configuração Master dos Banners
SLIDES_CONFIG = [
    {
        "id": 1,
        "type": "single",
        "raw_file": "screen_1.png",
        "pt": {
            "badge": "CORAM DEO • VIDA ESPIRITUAL",
            "title": "PRESENÇA DE DEUS",
            "subtitle": "Viva cada instante diante do olhar amoroso de Deus",
            "filename": "01_home_dark.png"
        },
        "en": {
            "badge": "CORAM DEO • SPIRITUAL LIFE",
            "title": "PRESENCE OF GOD",
            "subtitle": "Live each moment before the loving gaze of God",
            "filename": "01_home_dark.png"
        }
    },
    {
        "id": 2,
        "type": "single",
        "raw_file": "screen_2.png",
        "pt": {
            "badge": "HÁBITOS DE PIEDADE",
            "title": "PLANO DE VIDA ESPIRITUAL",
            "subtitle": "Organize suas orações diárias com metas e lembretes",
            "filename": "02_plano_de_vida.png"
        },
        "en": {
            "badge": "DAILY DEVOTIONS",
            "title": "SPIRITUAL PLAN OF LIFE",
            "subtitle": "Structure your daily prayers with goals and reminders",
            "filename": "02_plano_de_vida.png"
        }
    },
    {
        "id": 3,
        "type": "single",
        "raw_file": "screen_3.png",
        "pt": {
            "badge": "SAGRADA ESCRITURA",
            "title": "BÍBLIA SAGRADA OFFLINE",
            "subtitle": "Tradução Ave Maria e Cânon Católico de 73 livros",
            "filename": "03_biblia.png"
        },
        "en": {
            "badge": "SACRED SCRIPTURE",
            "title": "HOLY BIBLE OFFLINE",
            "subtitle": "Ave Maria translation & complete 73-book Catholic Canon",
            "filename": "03_biblia.png"
        }
    },
    {
        "id": 4,
        "type": "single",
        "raw_file": "screen_4.png",
        "pt": {
            "badge": "ORAÇÕES DA IGREJA",
            "title": "MODO BILÍNGUE PARALELO",
            "subtitle": "Orações em Latim e Português lado a lado",
            "filename": "04_oracoes_bilingues.png"
        },
        "en": {
            "badge": "CHURCH PRAYERS",
            "title": "SIDE-BY-SIDE BILINGUAL",
            "subtitle": "Latin and vernacular prayers with aligned stanzas",
            "filename": "04_oracoes_bilingues.png"
        }
    },
    {
        "id": 5,
        "type": "single",
        "raw_file": "screen_5.png",
        "pt": {
            "badge": "BIBLIOTECA CATÓLICA",
            "title": "LIVROS ESPIRITUAIS",
            "subtitle": "Caminho, Santo Rosário e obras de São Josemaria",
            "filename": "05_livros.png"
        },
        "en": {
            "badge": "SPIRITUAL CLASSICS",
            "title": "SPIRITUAL READINGS",
            "subtitle": "The Way, Holy Rosary, and works by St. Josemaría",
            "filename": "05_livros.png"
        }
    },
    {
        "id": 6,
        "type": "single",
        "raw_file": "screen_6.png",
        "pt": {
            "badge": "ALIMENTO DA ALMA",
            "title": "LITURGIA & MEDITAÇÕES",
            "subtitle": "Leituras da Santa Missa e reflexões diárias",
            "filename": "06_liturgia_diaria.png"
        },
        "en": {
            "badge": "DAILY INSPIRATION",
            "title": "LITURGY & MEDITATIONS",
            "subtitle": "Daily Mass readings and spiritual meditations",
            "filename": "06_liturgia_diaria.png"
        }
    },
    {
        "id": 7,
        "type": "single",
        "raw_file": "screen_7.png",
        "pt": {
            "badge": "CRESCIMENTO INTERIOR",
            "title": "ANÁLISE DE PROGRESSO",
            "subtitle": "Acompanhe sua constância e histórico de hábitos",
            "filename": "07_progresso.png"
        },
        "en": {
            "badge": "INTERIOR GROWTH",
            "title": "PROGRESS TRACKER",
            "subtitle": "Monitor your consistency and devotion history",
            "filename": "07_progresso.png"
        }
    },
    {
        "id": 8,
        "type": "dual",
        "raw_light": "screen_8.png",
        "raw_dark": "screen_1.png",
        "pt": {
            "badge": "DESIGN MODERNO",
            "title": "TEMA CLARO & ESCURO",
            "subtitle": "Interface serena adaptável com Material You",
            "filename": "08_tema_claro_escuro.png"
        },
        "en": {
            "badge": "MODERN DESIGN",
            "title": "LIGHT & DARK THEMES",
            "subtitle": "Serene interface with Material You dynamic colors",
            "filename": "08_tema_claro_escuro.png"
        }
    },
    {
        "id": 9,
        "type": "single_backup",
        "pt": {
            "raw_file": "screen_backup_pt.png",
            "badge": "SEGURANÇA & NUVEM",
            "title": "DADOS SALVOS NA NUVEM",
            "subtitle": "Backup diário automático vinculado à sua conta Google",
            "filename": "08_backup_seguranca.png"
        },
        "en": {
            "raw_file": "screen_backup_en.png",
            "badge": "SECURITY & CLOUD",
            "title": "DATA SECURED IN CLOUD",
            "subtitle": "Automatic daily backup linked to your Google Account",
            "filename": "08_backup_seguranca.png"
        }
    }
]

def main():
    parser = argparse.ArgumentParser(description="Gerador de Banners para Play Store do Coram Deo")
    parser.add_argument("--lang", choices=["all", "pt", "en"], default="all", help="Idioma dos banners (pt, en ou all)")
    args = parser.parse_args()

    print("=" * 68)
    print("Coram Deo — Gerador de Screenshots para Google Play Store (1080x1920)")
    print("=" * 68)

    print("\n[1/3] Gerando mockups vetoriais nativos de Backup...")
    generate_vector_backup_screens()
    print("  ✓ Telas de backup em alta definição geradas com sucesso.")

    langs_to_generate = ["pt", "en"] if args.lang == "all" else [args.lang]

    for lang in langs_to_generate:
        out_dir = OUTPUT_PT_DIR if lang == "pt" else OUTPUT_EN_DIR
        lang_label = "Português (pt-BR)" if lang == "pt" else "Inglês (en-US)"
        print(f"\n[2/3] Gerando vitrine em {lang_label} em: {out_dir}")

        for slide in SLIDES_CONFIG:
            info = slide[lang]
            dest_path = os.path.join(out_dir, info["filename"])

            if slide["type"] == "dual":
                render_dual_banner(
                    light_raw=os.path.join(RAW_DIR, slide["raw_light"]),
                    dark_raw=os.path.join(RAW_DIR, slide["raw_dark"]),
                    badge=info["badge"],
                    title=info["title"],
                    subtitle=info["subtitle"],
                    output_path=dest_path
                )
            elif slide["type"] == "single_backup":
                raw_path = os.path.join(RAW_DIR, info["raw_file"])
                render_banner(
                    raw_path=raw_path,
                    badge=info["badge"],
                    title=info["title"],
                    subtitle=info["subtitle"],
                    output_path=dest_path
                )
            else:
                raw_path = os.path.join(RAW_DIR, slide["raw_file"])
                render_banner(
                    raw_path=raw_path,
                    badge=info["badge"],
                    title=info["title"],
                    subtitle=info["subtitle"],
                    output_path=dest_path
                )

    print("\n" + "=" * 68)
    print("Processamento concluído com sucesso!")
    print(f"• Banners em Português: {OUTPUT_PT_DIR}")
    print(f"• Banners em Inglês:    {OUTPUT_EN_DIR}")
    print("=" * 68)

if __name__ == "__main__":
    main()
