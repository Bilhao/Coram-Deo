#!/usr/bin/env python3
"""
Gera o banco de dados SQLite para a Bíblia Católica (Cânon de 73 livros).
Utiliza como fonte a tradução Ave Maria com os 7 livros deuterocanônicos
(Tobias, Judite, 1 Macabeus, 2 Macabeus, Sabedoria, Eclesiástico, Baruc)
e os acréscimos aos livros de Daniel e Ester.
"""

import json
import os
import re
import sqlite3
import urllib.request

SOURCE_URL = "https://raw.githubusercontent.com/fidalgobr/bibliaAveMariaJSON/master/bibliaAveMaria.json"
OUTPUT_DB = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "assets", "biblia_ave_maria.db")

def clean_text(text: str) -> str:
    if not text:
        return ""
    # Remove soft hyphens usados para quebra de linha em impressão
    text = text.replace("\xad", "")
    # Remove asteriscos de chamada de notas de rodapé
    text = text.replace("*", "")
    # Normaliza múltiplos espaços e espaços nas bordas
    text = re.sub(r"\s+", " ", text).strip()
    return text

def build_database():
    print(f"Baixando dados da Bíblia Católica de: {SOURCE_URL}...")
    req = urllib.request.Request(SOURCE_URL, headers={"User-Agent": "Mozilla/5.0"})
    with urllib.request.urlopen(req) as resp:
        raw_content = resp.read().decode("utf-8")
        data = json.loads(raw_content)

    os.makedirs(os.path.dirname(OUTPUT_DB), exist_ok=True)
    if os.path.exists(OUTPUT_DB):
        os.remove(OUTPUT_DB)

    print(f"Criando banco SQLite em: {OUTPUT_DB}...")
    conn = sqlite3.connect(OUTPUT_DB)
    cursor = conn.cursor()

    cursor.execute("""
        CREATE TABLE bible (
            testament TEXT NOT NULL,
            book_id INTEGER NOT NULL,
            book TEXT NOT NULL,
            chapter INTEGER NOT NULL,
            verse_id INTEGER NOT NULL,
            verse TEXT NOT NULL
        )
    """)

    book_id = 1
    total_verses = 0

    # 1. Antigo Testamento (46 livros)
    ot_books = data.get("antigoTestamento", [])
    print(f"Processando Antigo Testamento ({len(ot_books)} livros)...")
    for book in ot_books:
        book_name = clean_text(book["nome"])
        testament = "Old"
        for ch in book["capitulos"]:
            ch_num = int(ch["capitulo"])
            for v in ch["versiculos"]:
                v_num = int(v["versiculo"])
                v_text = clean_text(v["texto"])
                cursor.execute(
                    "INSERT INTO bible (testament, book_id, book, chapter, verse_id, verse) VALUES (?, ?, ?, ?, ?, ?)",
                    (testament, book_id, book_name, ch_num, v_num, v_text)
                )
                total_verses += 1
        book_id += 1

    # 2. Novo Testamento (27 livros)
    nt_books = data.get("novoTestamento", [])
    print(f"Processando Novo Testamento ({len(nt_books)} livros)...")
    for book in nt_books:
        book_name = clean_text(book["nome"])
        testament = "New"
        for ch in book["capitulos"]:
            ch_num = int(ch["capitulo"])
            for v in ch["versiculos"]:
                v_num = int(v["versiculo"])
                v_text = clean_text(v["texto"])
                cursor.execute(
                    "INSERT INTO bible (testament, book_id, book, chapter, verse_id, verse) VALUES (?, ?, ?, ?, ?, ?)",
                    (testament, book_id, book_name, ch_num, v_num, v_text)
                )
                total_verses += 1
        book_id += 1

    total_books = book_id - 1
    print(f"Total de livros inseridos: {total_books}")
    print(f"Total de versículos inseridos: {total_verses}")

    # Criação dos índices de consulta de alta performance
    print("Criando índices de alta performance...")
    cursor.execute("CREATE INDEX idx_bible_book_chapter ON bible (book, chapter);")
    cursor.execute("CREATE INDEX idx_bible_book_id ON bible (book_id);")
    cursor.execute("CREATE INDEX idx_bible_testament ON bible (testament);")

    conn.commit()

    # Otimização com VACUUM e ANALYZE
    cursor.execute("PRAGMA optimize;")
    conn.commit()
    conn.close()

    db_size = os.path.getsize(OUTPUT_DB) / (1024 * 1024)
    print(f"Banco gerado com sucesso! Tamanho final: {db_size:.2f} MB")

if __name__ == "__main__":
    build_database()

