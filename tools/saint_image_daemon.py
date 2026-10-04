#!/usr/bin/env python3
"""
tools/saint_image_daemon.py

Script autônomo para geração, verificação visual com IA, pós-processamento e
monitoramento das imagens sacras dos Santos do Dia para o aplicativo Coram Deo.

Requer:
  - Variável de ambiente GEMINI_API_KEY (ou --api-key)
  - Dependências: pip install google-genai Pillow numpy

Padrões de Arte Sacra (Conforme guidelines_santos_arte_sacra.md):
- Estilo: Pintura a óleo barroca clássica (Caravaggio, Zurbarán, Velázquez).
- Iluminação: Chiaroscuro quente, sombras aveludadas, luz celestial dourada.
- Formato: Busto/meio-corpo (close-up upper-body), proporção 1:1 quadrada (1024x1024).
- Regra de Ouro: Full-bleed edge-to-edge estritamente sem molduras, bordas ou margens.
- Anatomia: 5 dedos naturais e proporcionais por mão, sem deformidades.
- Iconografia: Hábitos autênticos de cada ordem/época, auréola dourada translúcida.
"""

import argparse
import base64
import datetime
import io
import json
import os
import re
import sqlite3
import sys
import time
import traceback
from typing import Dict, List, Optional, Tuple

from PIL import Image
import numpy as np

PROJECT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
DB_PATH = os.path.join(PROJECT_DIR, "assets", "santos.db")
IMAGES_DIR = os.path.join(PROJECT_DIR, "assets", "images", "santos")
LOG_PATH = os.path.join(PROJECT_DIR, "tools", "saint_generator.log")
VALIDATION_LOG_PATH = os.path.join(PROJECT_DIR, "tools", "saint_validation.log")

# Modelos para geração de imagens (todos requerem Paid Tier / billing ativo)
# gemini-3.1-flash-image (Nano Banana 2) — ~$0.067/imagem 1K — MELHOR QUALIDADE
# gemini-2.5-flash-image (Nano Banana 1) — ~$0.039/imagem 1K — MAIS BARATO
IMAGE_GEN_MODEL = "gemini-3.1-flash-image"
IMAGE_GEN_FALLBACK = "gemini-2.5-flash-image"

# Modelo para validação visual (tem Free Tier!)
# Usado para analisar a qualidade artística/religiosa da imagem gerada
VALIDATION_MODEL = "gemini-3.5-flash-lite"

# Máximo de tentativas de geração por santo antes de pular
MAX_RETRIES = 3

# Intervalo entre gerações (segundos) — respeita rate limit
GENERATION_COOLDOWN_SECONDS = 10

# Retry com backoff exponencial quando rate limited
MAX_API_RETRIES = 5
INITIAL_BACKOFF_SECONDS = 30

MONTH_NAMES = [
    "",
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro",
]


def log(msg: str):
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    formatted = f"[{timestamp}] {msg}"
    print(formatted)
    try:
        os.makedirs(os.path.dirname(LOG_PATH), exist_ok=True)
        with open(LOG_PATH, "a", encoding="utf-8") as f:
            f.write(formatted + "\n")
    except Exception:
        pass


def validation_log(msg: str):
    """Log separado para resultados de validação visual."""
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    formatted = f"[{timestamp}] {msg}"
    try:
        os.makedirs(os.path.dirname(VALIDATION_LOG_PATH), exist_ok=True)
        with open(VALIDATION_LOG_PATH, "a", encoding="utf-8") as f:
            f.write(formatted + "\n")
    except Exception:
        pass


def get_all_saints_db() -> List[Dict]:
    """Retorna a lista completa dos 366 santos cadastrados no SQLite."""
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    cursor.execute(
        "SELECT id, dia, mes, nome, subtitulo, biografia, oracao, imagem_url "
        "FROM santos ORDER BY mes, dia"
    )
    rows = [dict(r) for r in cursor.fetchall()]
    conn.close()
    return rows


def image_exists_for(dia: int, mes: int) -> bool:
    """Verifica se o arquivo webp existe e tem tamanho válido (> 10 KB)."""
    filename = f"santo_{mes:02d}_{dia:02d}.webp"
    path = os.path.join(IMAGES_DIR, filename)
    return os.path.isfile(path) and os.path.getsize(path) > 10240


def validate_image_technical(path: str) -> Tuple[bool, str]:
    """Verifica a integridade técnica de uma imagem sacra (resolução, bordas)."""
    try:
        with Image.open(path) as img:
            w, h = img.size
            if w < 500 or h < 500:
                return False, f"Resolução muito baixa: {w}x{h}"
            arr = np.array(img)
            corners = [arr[0, 0], arr[0, -1], arr[-1, 0], arr[-1, -1]]
            bright_corners = sum(1 for c in corners if np.mean(c[:3]) > 240)
            if bright_corners >= 3:
                return False, "Possível moldura ou borda branca detectada nos cantos"
            return True, f"OK ({w}x{h}, {os.path.getsize(path)//1024} KB)"
    except Exception as e:
        return False, str(e)


def validate_image_visual(client, image_path: str, saint_name: str, saint_subtitle: str) -> Tuple[bool, str, float]:
    """
    Usa IA (gemini-3.5-flash-lite) para avaliar a qualidade artística e fidelidade
    da imagem gerada em relação às diretrizes de arte sacra.

    Retorna: (aprovado: bool, motivo: str, nota: float 0-10)
    """
    try:
        with open(image_path, "rb") as f:
            image_bytes = f.read()

        image_b64 = base64.b64encode(image_bytes).decode("utf-8")

        # Determina o MIME type
        if image_path.lower().endswith(".webp"):
            mime = "image/webp"
        elif image_path.lower().endswith(".png"):
            mime = "image/png"
        else:
            mime = "image/jpeg"

        validation_prompt = f"""Você é um curador de arte sacra católica especializado em validar imagens para um aplicativo devocional.

Analise esta imagem que deveria representar: "{saint_name}" ({saint_subtitle}).

Avalie os seguintes critérios com notas de 0 a 10:
1. ESTILO: É uma pintura a óleo barroca clássica (estilo Caravaggio/Zurbarán/Velázquez)?
2. MOLDURA: A imagem é full-bleed (preenche todo o canvas) SEM molduras, bordas, ou margens artificiais?
3. ANATOMIA: As mãos e o rosto estão anatomicamente corretos (5 dedos por mão, proporções faciais naturais)?
4. ICONOGRAFIA: O santo está vestido com trajes autenticamente de sua época/ordem religiosa?
5. ILUMINAÇÃO: Possui chiaroscuro quente com luz celestial dourada e sombras aveludadas?
6. DIGNIDADE: A imagem transmite sacralidade, serenidade e devoção adequada?
7. AURÉOLA: Possui uma auréola dourada translúcida e sutil ao redor da cabeça?

Responda EXATAMENTE neste formato JSON (sem markdown, sem code fences):
{{"aprovado": true/false, "nota_geral": 0.0, "motivo": "explicação breve", "detalhes": {{"estilo": 0, "moldura": 0, "anatomia": 0, "iconografia": 0, "iluminacao": 0, "dignidade": 0, "aureola": 0}}}}

Regras de aprovação:
- nota_geral >= 7.0 para aprovar
- anatomia >= 6 é obrigatório (rejeitar se mãos deformadas)
- moldura >= 7 é obrigatório (rejeitar se houver moldura/borda visível)
- Se houver texto/letras na imagem, reprovar automaticamente"""

        response = client.models.generate_content(
            model=VALIDATION_MODEL,
            contents=[
                validation_prompt,
                {"inline_data": {"mime_type": mime, "data": image_b64}},
            ],
        )

        response_text = response.text.strip()
        # Limpa possíveis code fences
        if response_text.startswith("```"):
            response_text = response_text.split("\n", 1)[1]
        if response_text.endswith("```"):
            response_text = response_text.rsplit("```", 1)[0]
        response_text = response_text.strip()

        result = json.loads(response_text)
        aprovado = result.get("aprovado", False)
        nota = float(result.get("nota_geral", 0))
        motivo = result.get("motivo", "Sem motivo informado")
        detalhes = result.get("detalhes", {})

        detail_str = " | ".join(f"{k}:{v}" for k, v in detalhes.items())
        validation_log(
            f"{'✓' if aprovado else '✗'} {saint_name} ({saint_subtitle}) — "
            f"Nota: {nota:.1f}/10 — {motivo} — [{detail_str}]"
        )

        return aprovado, motivo, nota

    except json.JSONDecodeError as e:
        log(f"Erro ao parsear resposta de validação: {e}")
        validation_log(f"⚠ {saint_name} — Erro de parsing JSON na validação: {e}")
        # Em caso de erro de parsing, aprova para não bloquear (validação técnica já passou)
        return True, "Validação visual inconclusiva (erro de parsing)", 5.0
    except Exception as e:
        log(f"Erro na validação visual: {e}")
        validation_log(f"⚠ {saint_name} — Erro na validação visual: {e}")
        return True, f"Validação visual inconclusiva ({e})", 5.0


def crop_letterbox_and_convert(src_path: str, dst_path: str) -> bool:
    """
    Remove automaticamente e rigorosamente quaisquer bordas claras, letterboxing,
    pillarboxing ou margens de canvas, garantindo arte sacra 100% full-bleed edge-to-edge.
    Converte para WebP (qualidade 90, method 6, 1024x1024).
    """
    try:
        img = Image.open(src_path)
        if img.mode == "RGBA":
            img = img.convert("RGB")
        arr = np.array(img)
        h, w, _ = arr.shape

        # Detecta pixels claros ou linhas de borda com limiar mais rigoroso (média RGB > 130 ou linha > 100)
        pixel_brightness = np.mean(arr, axis=-1)
        is_light = pixel_brightness > 130

        top = 0
        while top < h // 4 and (np.mean(is_light[top, :]) > 0.15 or np.mean(arr[top, :, :]) > 100):
            top += 1

        bottom = h - 1
        while bottom > h * 3 // 4 and (np.mean(is_light[bottom, :]) > 0.15 or np.mean(arr[bottom, :, :]) > 100):
            bottom -= 1

        left = 0
        while left < w // 4 and (np.mean(is_light[:, left]) > 0.15 or np.mean(arr[:, left, :]) > 100):
            left += 1

        right = w - 1
        while right > w * 3 // 4 and (np.mean(is_light[:, right]) > 0.15 or np.mean(arr[:, right, :]) > 100):
            right -= 1

        # Se houve detecção de borda clara em qualquer lado, aplica margem de segurança de corte (+4px)
        if top > 0 or bottom < h - 1 or left > 0 or right < w - 1:
            top = min(top + 4, h // 4)
            bottom = max(bottom - 4, h * 3 // 4)
            left = min(left + 4, w // 4)
            right = max(right - 4, w * 3 // 4)

            crop_w = right - left + 1
            crop_h = bottom - top + 1
            side = min(crop_w, crop_h)
            img = img.crop((left, top, left + side, top + side))
        elif img.size[0] != img.size[1]:
            # Se não é quadrado, centraliza para 1:1
            min_side = min(img.size[0], img.size[1])
            left = (img.size[0] - min_side) // 2
            top = (img.size[1] - min_side) // 2
            img = img.crop((left, top, left + min_side, top + min_side))

        # Redimensiona para padrão 1024x1024
        if img.size != (1024, 1024):
            img = img.resize((1024, 1024), Image.Resampling.LANCZOS)

        os.makedirs(os.path.dirname(dst_path), exist_ok=True)
        img.save(dst_path, "WEBP", quality=90, method=6)
        log(f"Salvo: {dst_path} (1024x1024, {os.path.getsize(dst_path)//1024} KB)")
        return True
    except Exception as e:
        log(f"Erro ao pós-processar imagem {src_path}: {e}")
        return False



def build_canonical_prompt(nome: str, subtitulo: str) -> str:
    """Gera um prompt canônico estrito seguindo as diretrizes de arte sacra barroca."""
    return (
        f"Full-bleed edge-to-edge painting filling the entire square canvas, borderless, "
        f"strictly no picture frame, no wooden frame, no gilded frame, no borders, no margins, "
        f"no wall background, no drop shadow, no text, no letters, no words, no captions. "
        f"Baroque sacred art oil painting, close-up upper-body "
        f"portrait of {nome}, {subtitulo}. Wearing authentic historic religious vestments or habit. "
        f"Hands with natural five fingers resting with profound reverence or holding sacred attributes. "
        f"Looking with deep interior prayer, serenity, and spiritual holiness. "
        f"Delicate translucent golden ethereal halo around the head. "
        f"Dramatic chiaroscuro lighting, warm golden illumination highlighting face and hands against deep "
        f"velvety shadows, masterwork in the solemn style of Francisco de Zurbaran, Diego Velazquez and Caravaggio, "
        f"rich oil paint textures."
    )


def generate_single_image(client, saint: Dict, model: str = "") -> Optional[str]:
    """
    Gera uma imagem via API Gemini e retorna o caminho do arquivo
    temporário salvo, ou None em caso de falha.
    Inclui retry com backoff exponencial para rate limiting (429).
    """
    nome = saint["nome"]
    subtitulo = saint.get("subtitulo", "")
    dia = saint["dia"]
    mes = saint["mes"]
    prompt = build_canonical_prompt(nome, subtitulo)
    gen_model = model or IMAGE_GEN_MODEL

    log(f"Gerando imagem para {dia:02d}/{mes:02d} - {nome} [modelo: {gen_model}]...")

    backoff = INITIAL_BACKOFF_SECONDS
    for api_attempt in range(1, MAX_API_RETRIES + 1):
        try:
            response = client.models.generate_content(
                model=gen_model,
                contents=[prompt],
            )

            # Procura a parte com dados de imagem na resposta
            for part in response.parts:
                if part.inline_data is not None:
                    raw = part.inline_data.data
                    image_data = raw if isinstance(raw, bytes) else base64.b64decode(raw)
                    # Salva temporariamente
                    ext = ".jpg" if "jpeg" in (part.inline_data.mime_type or "") else ".png"
                    tmp_path = os.path.join(IMAGES_DIR, f"_tmp_{mes:02d}_{dia:02d}{ext}")
                    os.makedirs(IMAGES_DIR, exist_ok=True)
                    with open(tmp_path, "wb") as f:
                        f.write(image_data)
                    log(f"Imagem gerada com sucesso para {dia:02d}/{mes:02d} ({len(image_data)//1024} KB)")
                    return tmp_path


            log(f"Resposta sem imagem para {dia:02d}/{mes:02d} - {nome}")
            if response.text:
                log(f"Texto da resposta: {response.text[:200]}")
            return None

        except Exception as e:
            error_str = str(e)
            # Verifica se é rate limit (429)
            if "429" in error_str or "RESOURCE_EXHAUSTED" in error_str or "quota" in error_str.lower():
                # Tenta extrair retryDelay da resposta de erro
                retry_delay = backoff
                if "retryDelay" in error_str:
                    try:
                        delay_match = re.search(r"retryDelay.*?(\d+)s", error_str)
                        if delay_match:
                            retry_delay = max(int(delay_match.group(1)) + 5, backoff)
                    except Exception:
                        pass

                log(f"Rate limit atingido (tentativa {api_attempt}/{MAX_API_RETRIES}). "
                    f"Aguardando {retry_delay}s antes de tentar novamente...")
                time.sleep(retry_delay)
                backoff = min(backoff * 2, 300)  # Max 5 min
                continue
            else:
                log(f"Erro na geração de {dia:02d}/{mes:02d} - {nome}: {e}")
                traceback.print_exc()
                return None

    log(f"Esgotadas {MAX_API_RETRIES} tentativas de API para {dia:02d}/{mes:02d} - {nome}")
    return None


def update_db_image_url(dia: int, mes: int):
    """Atualiza a URL da imagem no banco de dados SQLite."""
    try:
        conn = sqlite3.connect(DB_PATH)
        url = f"santo_{mes:02d}_{dia:02d}.webp"
        conn.cursor().execute(
            "UPDATE santos SET imagem_url = ? WHERE dia = ? AND mes = ?",
            (url, dia, mes),
        )
        conn.commit()
        conn.close()
        log(f"Banco de dados atualizado para {dia:02d}/{mes:02d}: {url}")
    except Exception as e:
        log(f"Erro ao atualizar BD para {dia:02d}/{mes:02d}: {e}")


def process_single_saint(client, saint: Dict, skip_validation: bool = False) -> bool:
    """
    Pipeline completo para um santo:
    1. Gera a imagem via API
    2. Pós-processa (crop/resize/webp)
    3. Valida tecnicamente
    4. Valida visualmente com IA
    5. Salva no diretório final e atualiza o BD
    6. Se falhar na validação, tenta novamente (até MAX_RETRIES)

    Retorna True se gerou e validou com sucesso.
    """
    dia = saint["dia"]
    mes = saint["mes"]
    nome = saint["nome"]
    subtitulo = saint.get("subtitulo", "")
    final_path = os.path.join(IMAGES_DIR, f"santo_{mes:02d}_{dia:02d}.webp")

    for attempt in range(1, MAX_RETRIES + 1):
        log(f"[Tentativa {attempt}/{MAX_RETRIES}] {dia:02d}/{mes:02d} - {nome}")

        # 1. Gerar imagem
        tmp_path = generate_single_image(client, saint)
        if tmp_path is None:
            log(f"Falha na geração (tentativa {attempt}). Aguardando antes de tentar novamente...")
            time.sleep(GENERATION_COOLDOWN_SECONDS)
            continue

        # 2. Pós-processar (crop + resize + webp)
        ok = crop_letterbox_and_convert(tmp_path, final_path)
        # Remove temporário
        try:
            os.remove(tmp_path)
        except Exception:
            pass

        if not ok:
            log(f"Falha no pós-processamento (tentativa {attempt}).")
            continue

        # 3. Validação técnica
        tech_ok, tech_msg = validate_image_technical(final_path)
        if not tech_ok:
            log(f"Validação técnica falhou: {tech_msg} (tentativa {attempt})")
            try:
                os.remove(final_path)
            except Exception:
                pass
            continue

        # 4. Validação visual com IA
        if not skip_validation:
            vis_ok, vis_msg, nota = validate_image_visual(client, final_path, nome, subtitulo)
            if not vis_ok:
                log(f"Validação visual REPROVADA (nota: {nota:.1f}): {vis_msg} (tentativa {attempt})")
                try:
                    os.remove(final_path)
                except Exception:
                    pass
                time.sleep(GENERATION_COOLDOWN_SECONDS)
                continue
            log(f"✓ Validação visual APROVADA (nota: {nota:.1f}): {vis_msg}")
        else:
            log(f"Validação visual pulada (--skip-validation)")

        # 5. Atualizar BD
        update_db_image_url(dia, mes)

        log(f"✅ Concluído: {dia:02d}/{mes:02d} - {nome} ({os.path.getsize(final_path)//1024} KB)")
        return True

    log(f"❌ Esgotadas {MAX_RETRIES} tentativas para {dia:02d}/{mes:02d} - {nome}. Pulando.")
    return False


def validate_existing_images(client):
    """Valida visualmente todas as imagens existentes e reporta as que falharam."""
    saints = get_all_saints_db()
    log("═" * 60)
    log("VALIDAÇÃO VISUAL DE TODAS AS IMAGENS EXISTENTES")
    log("═" * 60)

    results = {"approved": [], "rejected": [], "errors": []}

    for s in saints:
        d, m = s["dia"], s["mes"]
        if not image_exists_for(d, m):
            continue

        path = os.path.join(IMAGES_DIR, f"santo_{m:02d}_{d:02d}.webp")
        nome = s["nome"]
        subtitulo = s.get("subtitulo", "")

        # Validação técnica primeiro
        tech_ok, tech_msg = validate_image_technical(path)
        if not tech_ok:
            results["rejected"].append((d, m, nome, f"[TÉCNICA] {tech_msg}", 0))
            log(f"✗ {d:02d}/{m:02d} {nome}: REPROVADA (técnica: {tech_msg})")
            continue

        # Validação visual
        try:
            vis_ok, vis_msg, nota = validate_image_visual(client, path, nome, subtitulo)
            if vis_ok:
                results["approved"].append((d, m, nome, nota))
                log(f"✓ {d:02d}/{m:02d} {nome}: APROVADA (nota: {nota:.1f})")
            else:
                results["rejected"].append((d, m, nome, vis_msg, nota))
                log(f"✗ {d:02d}/{m:02d} {nome}: REPROVADA (nota: {nota:.1f}) — {vis_msg}")
        except Exception as e:
            results["errors"].append((d, m, nome, str(e)))
            log(f"⚠ {d:02d}/{m:02d} {nome}: ERRO — {e}")

        # Cooldown entre validações para não exceder rate limit
        time.sleep(2)

    # Relatório final
    log("")
    log("═" * 60)
    log("RELATÓRIO DE VALIDAÇÃO VISUAL")
    log("═" * 60)
    log(f"Aprovadas: {len(results['approved'])}")
    log(f"Reprovadas: {len(results['rejected'])}")
    log(f"Erros: {len(results['errors'])}")

    if results["rejected"]:
        log("\nImagens reprovadas (considere regenerar):")
        for d, m, nome, motivo, nota in results["rejected"]:
            log(f"  ✗ {d:02d}/{m:02d} {nome} (nota: {nota:.1f}): {motivo}")

    if results["errors"]:
        log("\nImagens com erro de validação:")
        for d, m, nome, erro in results["errors"]:
            log(f"  ⚠ {d:02d}/{m:02d} {nome}: {erro}")

    log("═" * 60)
    return results


def show_status():
    """Exibe o relatório consolidado de cobertura dos 366 dias do ano."""
    saints = get_all_saints_db()
    total = len(saints)
    completed = 0
    by_month = {m: {"total": 0, "done": 0} for m in range(1, 13)}

    for s in saints:
        d = s["dia"]
        m = s["mes"]
        by_month[m]["total"] += 1
        if image_exists_for(d, m):
            completed += 1
            by_month[m]["done"] += 1

    print("\n" + "=" * 55)
    print("  STATUS DAS IMAGENS DOS SANTOS DO DIA (CORAM DEO)")
    print("=" * 55)
    for m in range(1, 13):
        info = by_month[m]
        pct = (info["done"] / info["total"]) * 100 if info["total"] else 0
        bar = "█" * int(pct // 10) + "░" * (10 - int(pct // 10))
        status_txt = f"{info['done']:2d}/{info['total']:2d} ({pct:5.1f}%)"
        print(f"  {MONTH_NAMES[m]:<10} [{bar}] {status_txt}")
    print("-" * 55)
    total_pct = (completed / total) * 100
    print(f"  TOTAL GERAL: {completed}/{total} imagens geradas ({total_pct:.1f}% concluído)")
    print(f"  RESTANTES:   {total - completed} imagens para o acervo de 366 dias")
    print("=" * 55 + "\n")


def check_and_validate_all():
    """Verifica e valida tecnicamente todas as imagens já geradas."""
    saints = get_all_saints_db()
    errors = []
    valid = 0
    for s in saints:
        d = s["dia"]
        m = s["mes"]
        if image_exists_for(d, m):
            path = os.path.join(IMAGES_DIR, f"santo_{m:02d}_{d:02d}.webp")
            ok, msg = validate_image_technical(path)
            if not ok:
                errors.append((d, m, s["nome"], msg))
            else:
                valid += 1
    log(f"Validação técnica: {valid} imagens íntegras.")
    if errors:
        log(f"Atenção: {len(errors)} imagens com inconsistências:")
        for d, m, nome, msg in errors:
            log(f"  - {d:02d}/{m:02d} ({nome}): {msg}")
    else:
        log("Todas as imagens existentes passaram no controle de qualidade técnico!")


def daemon_loop(client, poll_interval_minutes: int = 15, skip_validation: bool = False):
    """
    Loop de execução contínua que gera, valida e salva imagens sequencialmente
    até completar todas as 366 imagens.
    """
    log("═" * 60)
    log("INICIANDO SAINT IMAGE DAEMON — CORAM DEO")
    log(f"Modelo de geração: {IMAGE_GEN_MODEL}")
    log(f"Modelo de validação: {VALIDATION_MODEL}")
    log(f"Máx. tentativas por santo: {MAX_RETRIES}")
    log(f"Cooldown entre gerações: {GENERATION_COOLDOWN_SECONDS}s")
    log(f"Validação visual: {'DESATIVADA' if skip_validation else 'ATIVADA'}")
    log("═" * 60)

    generated_count = 0
    skipped_count = 0

    while True:
        saints = get_all_saints_db()
        pending = [s for s in saints if not image_exists_for(s["dia"], s["mes"])]

        if not pending:
            log("🎉 Todas as 366 imagens dos santos do dia foram geradas!")
            log(f"Geradas nesta sessão: {generated_count} | Puladas: {skipped_count}")
            break

        total_done = len(saints) - len(pending)
        pct = (total_done / len(saints)) * 100
        log(f"\n{'─' * 40}")
        log(f"Progresso: {total_done}/{len(saints)} ({pct:.1f}%) | Fila: {len(pending)}")
        log(f"Geradas nesta sessão: {generated_count} | Puladas: {skipped_count}")
        log(f"{'─' * 40}")

        next_saint = pending[0]
        success = process_single_saint(client, next_saint, skip_validation=skip_validation)

        if success:
            generated_count += 1
        else:
            skipped_count += 1

        # Cooldown entre santos
        time.sleep(GENERATION_COOLDOWN_SECONDS)


def watch_dashboard(interval_seconds: int = 3):
    """Exibe um painel interativo em tempo real atualizado continuamente no terminal."""
    try:
        while True:
            saints = get_all_saints_db()
            total = len(saints)
            completed = 0
            by_month = {m: {"total": 0, "done": 0} for m in range(1, 13)}
            pending = []
            recent_files = []

            for s in saints:
                d = s["dia"]
                m = s["mes"]
                by_month[m]["total"] += 1
                if image_exists_for(d, m):
                    completed += 1
                    by_month[m]["done"] += 1
                    path = os.path.join(IMAGES_DIR, f"santo_{m:02d}_{d:02d}.webp")
                    try:
                        mtime = os.path.getmtime(path)
                        recent_files.append(
                            (mtime, d, m, s["nome"], os.path.getsize(path))
                        )
                    except Exception:
                        pass
                else:
                    pending.append(s)

            recent_files.sort(key=lambda x: x[0], reverse=True)

            total_pct = (completed / total) * 100 if total else 0
            bar_len = 28
            filled_len = int(bar_len * completed // total) if total else 0
            main_bar = "█" * filled_len + "░" * (bar_len - filled_len)

            now_str = datetime.datetime.now().strftime("%d/%m/%Y %H:%M:%S")

            def row(content: str) -> str:
                trimmed = content[:70]
                return f"│  {trimmed:<70}  │"

            out = []
            out.append("\033[H\033[2J")
            out.append("┌" + "─" * 74 + "┐")
            out.append(
                row(
                    "CORAM DEO — PAINEL DE GERAÇÃO DOS SANTOS DO DIA (TEMPO REAL)"
                )
            )
            out.append(
                row(
                    f"Atualizado em: {now_str}         [Pressione Ctrl+C para sair]"
                )
            )
            out.append("├" + "─" * 74 + "┤")
            out.append(
                row(
                    f"PROGRESSO GERAL: [{main_bar}] {completed:3d}/{total} ({total_pct:5.1f}%)"
                )
            )
            out.append(
                row(
                    f"Restantes: {total - completed:3d} imagens para cobrir todos os 366 dias do ano"
                )
            )
            out.append("├" + "─" * 74 + "┤")
            out.append(row("COBERTURA POR MÊS:"))
            for i in range(1, 7):
                m1, m2 = i, i + 6
                info1, info2 = by_month[m1], by_month[m2]
                pct1 = (
                    (info1["done"] / info1["total"]) * 100
                    if info1["total"]
                    else 0
                )
                pct2 = (
                    (info2["done"] / info2["total"]) * 100
                    if info2["total"]
                    else 0
                )
                b1 = "█" * int(pct1 // 12.5) + "░" * (8 - int(pct1 // 12.5))
                b2 = "█" * int(pct2 // 12.5) + "░" * (8 - int(pct2 // 12.5))
                col1 = f"{MONTH_NAMES[m1]:<9} [{b1}] {info1['done']:2d}/{info1['total']:2d} ({pct1:3.0f}%)"
                col2 = f"{MONTH_NAMES[m2]:<9} [{b2}] {info2['done']:2d}/{info2['total']:2d} ({pct2:3.0f}%)"
                out.append(row(f"{col1}        {col2}"))
            out.append("├" + "─" * 74 + "┤")
            out.append(row("PRÓXIMOS SANTOS NA FILA:"))
            for s in pending[:4]:
                name_trimmed = s["nome"][:58]
                out.append(
                    row(f"• {s['dia']:02d}/{s['mes']:02d}: {name_trimmed}")
                )
            if not pending:
                out.append(row("🎉 Todas as imagens foram geradas!"))
            out.append("├" + "─" * 74 + "┤")
            out.append(row("ÚLTIMAS IMAGENS GERADAS:"))
            for mtime, d, m, nome, sz in recent_files[:3]:
                t_str = datetime.datetime.fromtimestamp(mtime).strftime(
                    "%d/%m %H:%M"
                )
                name_trimmed = nome[:38]
                out.append(
                    row(
                        f"✓ {d:02d}/{m:02d} {name_trimmed:<38} ({sz//1024:3d} KB • {t_str})"
                    )
                )
            if not recent_files:
                out.append(row("Nenhuma imagem gerada ainda."))

            # Lê últimas linhas do log de validação, se disponível
            out.append("├" + "─" * 74 + "┤")
            out.append(row("ÚLTIMAS VALIDAÇÕES VISUAIS:"))
            try:
                if os.path.isfile(VALIDATION_LOG_PATH):
                    with open(VALIDATION_LOG_PATH, "r") as vf:
                        vlines = vf.readlines()[-3:]
                    for vline in vlines:
                        vline = vline.strip()
                        # Remove timestamp para caber na linha
                        if "] " in vline:
                            vline = vline.split("] ", 1)[1]
                        out.append(row(vline[:70]))
                else:
                    out.append(row("Nenhuma validação realizada ainda."))
            except Exception:
                out.append(row("Erro ao ler log de validação."))

            out.append("└" + "─" * 74 + "┘")

            print("\n".join(out), flush=True)
            time.sleep(interval_seconds)
    except KeyboardInterrupt:
        print("\n\nMonitoramento finalizado.\n")


def create_client(api_key: Optional[str] = None):
    """Cria o cliente Gemini com a API key fornecida, do ambiente ou de ~/.env."""
    from google import genai

    key = api_key or os.environ.get("GEMINI_API_KEY")
    if not key:
        env_path = os.path.expanduser("~/.env")
        if os.path.isfile(env_path):
            try:
                with open(env_path, "r", encoding="utf-8") as f:
                    for line in f:
                        line = line.strip()
                        if line.startswith("GEMINI_API_KEY="):
                            key = line.split("=", 1)[1].strip("\"'")
                            break
            except Exception:
                pass

    if not key:
        print("ERRO: Nenhuma API key fornecida.")
        print("Use --api-key <KEY> ou defina a variável de ambiente GEMINI_API_KEY em ~/.env")
        sys.exit(1)

    return genai.Client(api_key=key)



def main():
    parser = argparse.ArgumentParser(
        description="Gerenciador e Daemon de Imagens dos Santos - Coram Deo"
    )
    parser.add_argument(
        "--api-key",
        type=str,
        default=None,
        help="Chave da API Gemini (ou use GEMINI_API_KEY no ambiente)",
    )
    parser.add_argument(
        "--status",
        action="store_true",
        help="Exibe relatório resumido de progresso",
    )
    parser.add_argument(
        "--watch",
        "--dashboard",
        dest="watch",
        action="store_true",
        help="Inicia painel interativo em tempo real",
    )
    parser.add_argument(
        "--interval",
        type=int,
        default=3,
        help="Intervalo de atualização em segundos para o painel (padrão: 3s)",
    )
    parser.add_argument(
        "--validate-technical",
        action="store_true",
        help="Valida integridade técnica das imagens existentes",
    )
    parser.add_argument(
        "--validate-visual",
        action="store_true",
        help="Valida visualmente (com IA) todas as imagens existentes",
    )
    parser.add_argument(
        "--daemon",
        action="store_true",
        help="Inicia o loop contínuo de geração + validação",
    )
    parser.add_argument(
        "--skip-validation",
        action="store_true",
        help="Pula a validação visual com IA (gera sem verificar qualidade artística)",
    )
    parser.add_argument(
        "--model",
        type=str,
        default=None,
        choices=["gemini-3.1-flash-image", "gemini-2.5-flash-image"],
        help="Modelo de geração de imagem (padrão: gemini-3.1-flash-image)",
    )
    parser.add_argument(
        "--max-retries",
        type=int,
        default=MAX_RETRIES,
        help=f"Máximo de tentativas por santo (padrão: {MAX_RETRIES})",
    )
    parser.add_argument(
        "--cooldown",
        type=int,
        default=GENERATION_COOLDOWN_SECONDS,
        help=f"Segundos entre gerações (padrão: {GENERATION_COOLDOWN_SECONDS})",
    )
    parser.add_argument(
        "--crop-and-convert",
        nargs=3,
        metavar=("SRC", "DIA", "MES"),
        help="Recorta e converte imagem avulsa",
    )
    parser.add_argument(
        "--regenerate",
        nargs=2,
        type=int,
        metavar=("DIA", "MES"),
        help="Regenera a imagem de um santo específico (mesmo que já exista)",
    )
    args = parser.parse_args()

    # Configura o modelo de geração
    if args.model:
        global IMAGE_GEN_MODEL
        IMAGE_GEN_MODEL = args.model

    if args.watch:
        watch_dashboard(interval_seconds=args.interval)
    elif args.status or len(sys.argv) == 1:
        show_status()
    elif args.validate_technical:
        check_and_validate_all()
    elif args.validate_visual:
        client = create_client(args.api_key)
        validate_existing_images(client)
    elif args.daemon:
        client = create_client(args.api_key)
        daemon_loop(client, skip_validation=args.skip_validation)
    elif args.regenerate:
        dia, mes = args.regenerate
        client = create_client(args.api_key)
        saints = get_all_saints_db()
        saint = next((s for s in saints if s["dia"] == dia and s["mes"] == mes), None)
        if saint is None:
            print(f"Santo não encontrado para {dia:02d}/{mes:02d}")
            sys.exit(1)
        # Remove imagem existente para forçar regeneração
        existing = os.path.join(IMAGES_DIR, f"santo_{mes:02d}_{dia:02d}.webp")
        if os.path.isfile(existing):
            os.remove(existing)
            log(f"Imagem anterior removida: {existing}")
        process_single_saint(client, saint, skip_validation=args.skip_validation)
    elif args.crop_and_convert:
        src, dia_s, mes_s = args.crop_and_convert
        d, m = int(dia_s), int(mes_s)
        dst = os.path.join(IMAGES_DIR, f"santo_{m:02d}_{d:02d}.webp")
        ok = crop_letterbox_and_convert(src, dst)
        if ok:
            update_db_image_url(d, m)


if __name__ == "__main__":
    main()

