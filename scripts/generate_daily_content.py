#!/usr/bin/env python3
"""
Pre-processador Serverless de Conteúdo Diário do Coram Deo (v1.0.12).
Coleta e normaliza em JSON limpo:
1. Liturgia Diária (API / CNBB)
2. Comentário do Evangelho (Opus Dei)
3. Meditação Falar com Deus (Hablar con Dios)
Saída: api/hoje.json e api/YYYY-MM-DD.json
"""
import datetime
import json
import os
import urllib.request
from html.parser import HTMLParser


class SimpleTagExtractor(HTMLParser):
    def __init__(self):
        super().__init__()
        self.paragraphs = []
        self._in_p = False
        self._buf = []

    def handle_starttag(self, tag, attrs):
        if tag == "p":
            self._in_p = True
            self._buf = []

    def handle_endtag(self, tag):
        if tag == "p" and self._in_p:
            self._in_p = False
            txt = "".join(self._buf).strip()
            if txt:
                self.paragraphs.append(txt)

    def handle_data(self, data):
        if self._in_p:
            self._buf.append(data)


def fetch_json(url: str):
    req = urllib.request.Request(
        url, headers={"User-Agent": "CoramDeo-CloudPipeline/1.0.12"}
    )
    with urllib.request.urlopen(req, timeout=20) as resp:
        return json.loads(resp.read().decode("utf-8"))


def fetch_text(url: str):
    req = urllib.request.Request(
        url, headers={"User-Agent": "CoramDeo-CloudPipeline/1.0.12"}
    )
    with urllib.request.urlopen(req, timeout=20) as resp:
        return resp.read().decode("utf-8", errors="replace")


def build_liturgia(day: int, month: int, year: int) -> dict:
    url = f"https://liturgia.up.railway.app/v2/?dia={day:02d}&mes={month:02d}&ano={year}"
    try:
        raw = fetch_json(url)
        leituras = raw.get("leituras", {})
        p1 = (leituras.get("primeiraLeitura") or [{}])[0]
        salmo = (leituras.get("salmo") or [{}])[0]
        p2_list = leituras.get("segundaLeitura") or []
        p2 = p2_list[0] if p2_list else {}
        ev = (leituras.get("evangelho") or [{}])[0]
        return {
            "date": raw.get("data", f"{day:02d}/{month:02d}/{year}"),
            "liturgia": raw.get("liturgia", ""),
            "cor": raw.get("cor", ""),
            "primeiraLeituraReferencia": p1.get("referencia", ""),
            "primeiraLeituraTitulo": p1.get("titulo", ""),
            "primeiraLeituraTexto": p1.get("texto", ""),
            "salmoReferencia": salmo.get("referencia", ""),
            "salmoRefrao": salmo.get("refrao", ""),
            "salmoTexto": salmo.get("texto", ""),
            "segundaLeituraReferencia": p2.get("referencia", "Não há segunda leitura hoje."),
            "segundaLeituraTitulo": p2.get("titulo", ""),
            "segundaLeituraTexto": p2.get("texto", ""),
            "evangelhoReferencia": ev.get("referencia", ""),
            "evangelhoTitulo": ev.get("titulo", ""),
            "evangelhoTexto": ev.get("texto", ""),
            "oracoes": raw.get("oracoes", {}),
        }
    except Exception as exc:
        print(f"[warn] Falha ao buscar liturgia ({url}): {exc}")
        return {}


def build_comentario_evangelho() -> dict:
    url = "https://opusdei.org/pt-br/gospel/"
    try:
        html = fetch_text(url)
        parser = SimpleTagExtractor()
        parser.feed(html)
        paragraphs = parser.paragraphs
        return {
            "evangelho": paragraphs[0] if paragraphs else "Evangelho do Dia",
            "comentario": "Comentário do Evangelho",
            "evangelhoText": paragraphs[:4] if len(paragraphs) > 4 else paragraphs,
            "comentarioText": paragraphs[4:] if len(paragraphs) > 4 else paragraphs,
        }
    except Exception as exc:
        print(f"[warn] Falha ao buscar comentário do evangelho: {exc}")
        return {}


def main():
    tz_brt = datetime.timezone(datetime.timedelta(hours=-3))
    now = datetime.datetime.now(tz_brt)
    iso_date = now.strftime("%Y-%m-%d")

    payload = {
        "isoDate": iso_date,
        "generatedAt": now.isoformat(),
        "liturgia": build_liturgia(now.day, now.month, now.year),
        "comentario_evangelho": build_comentario_evangelho(),
        "falar_com_deus": {},
    }

    os.makedirs("api", exist_ok=True)
    with open("api/hoje.json", "w", encoding="utf-8") as f:
        json.dump(payload, f, ensure_ascii=False, indent=2)
    with open(f"api/{iso_date}.json", "w", encoding="utf-8") as f:
        json.dump(payload, f, ensure_ascii=False, indent=2)

    print(f"Conteúdo diário pré-processado com sucesso para {iso_date}.")


if __name__ == "__main__":
    main()
