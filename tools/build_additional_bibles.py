#!/usr/bin/env python3
"""
Gera os bancos SQLite adicionais para a Bíblia Católica (Cânon de 73 livros)
e comprime com gzip (.db.gz) para distribuição sob demanda:
1. Pe. Manuel de Matos Soares (Português)
2. Douay-Rheims Bible (Inglês)
3. Vulgata Clementina (Latim)
4. Biblia Torres Amat / Platense (Espanhol)
"""

import gzip
import json
import os
import re
import sqlite3
import urllib.request

OUTPUT_DIR = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "assets", "downloads")

def clean_text(text: str) -> str:
    if not text:
        return ""
    text = text.replace("\xad", "")
    text = text.replace("*", "")
    text = re.sub(r"\s+", " ", text).strip()
    return text

def gzip_file(src: str, dst: str):
    with open(src, "rb") as f_in, gzip.open(dst, "wb") as f_out:
        f_out.writelines(f_in)

def build_matos_soares():
    print("--- Gerando Bíblia Pe. Manuel de Matos Soares ---")
    url = "https://raw.githubusercontent.com/natanael127/abra-sua-biblia/master/assets/data/bibles/pt_pe_matos_soares.ebf1.json"
    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
    with urllib.request.urlopen(req) as resp:
        data = json.loads(resp.read().decode("utf-8"))

    db_path = os.path.join(OUTPUT_DIR, "biblia_matos_soares.db")
    if os.path.exists(db_path):
        os.remove(db_path)

    conn = sqlite3.connect(db_path)
    c = conn.cursor()
    c.execute("""
        CREATE TABLE bible (
            testament TEXT NOT NULL,
            book_id INTEGER NOT NULL,
            book TEXT NOT NULL,
            chapter INTEGER NOT NULL,
            verse_id INTEGER NOT NULL,
            verse TEXT NOT NULL
        )
    """)

    books = data["bible"]["books"]
    for idx, b in enumerate(books):
        book_id = idx + 1
        testament = "Old" if book_id <= 46 else "New"
        book_name = clean_text(b["names"][0])
        for ch_idx, ch in enumerate(b["chapters"]):
            ch_num = ch_idx + 1
            for v_idx, v in enumerate(ch["verses"]):
                v_num = v_idx + 1
                text = clean_text(v.get("text", ""))
                c.execute(
                    "INSERT INTO bible (testament, book_id, book, chapter, verse_id, verse) VALUES (?, ?, ?, ?, ?, ?)",
                    (testament, book_id, book_name, ch_num, v_num, text)
                )

    c.execute("CREATE INDEX idx_bible_book_chapter ON bible (book, chapter);")
    c.execute("CREATE INDEX idx_bible_book_id ON bible (book_id);")
    c.execute("CREATE INDEX idx_bible_testament ON bible (testament);")
    conn.commit()
    conn.close()

    gz_path = db_path + ".gz"
    gzip_file(db_path, gz_path)
    print(f"Matos Soares gerado: {os.path.getsize(gz_path) / (1024*1024):.2f} MB")

def build_douay_rheims():
    print("--- Gerando Douay-Rheims Bible (Inglês) ---")
    url = "https://raw.githubusercontent.com/xxruyle/Bible-DouayRheims/master/EntireBible-DR.json"
    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
    with urllib.request.urlopen(req) as resp:
        data = json.loads(resp.read().decode("utf-8"))

    db_path = os.path.join(OUTPUT_DIR, "biblia_douay_rheims.db")
    if os.path.exists(db_path):
        os.remove(db_path)

    conn = sqlite3.connect(db_path)
    c = conn.cursor()
    c.execute("""
        CREATE TABLE bible (
            testament TEXT NOT NULL,
            book_id INTEGER NOT NULL,
            book TEXT NOT NULL,
            chapter INTEGER NOT NULL,
            verse_id INTEGER NOT NULL,
            verse TEXT NOT NULL
        )
    """)

    for idx, (book_name, chapters) in enumerate(data.items()):
        book_id = idx + 1
        testament = "Old" if book_id <= 46 else "New"
        for ch_str, verses in chapters.items():
            ch_num = int(ch_str)
            for v_str, text in verses.items():
                v_num = int(v_str)
                c.execute(
                    "INSERT INTO bible (testament, book_id, book, chapter, verse_id, verse) VALUES (?, ?, ?, ?, ?, ?)",
                    (testament, book_id, clean_text(book_name), ch_num, v_num, clean_text(text))
                )

    c.execute("CREATE INDEX idx_bible_book_chapter ON bible (book, chapter);")
    c.execute("CREATE INDEX idx_bible_book_id ON bible (book_id);")
    c.execute("CREATE INDEX idx_bible_testament ON bible (testament);")
    conn.commit()
    conn.close()

    gz_path = db_path + ".gz"
    gzip_file(db_path, gz_path)
    print(f"Douay-Rheims gerado: {os.path.getsize(gz_path) / (1024*1024):.2f} MB")

def build_vulgata():
    print("--- Gerando Vulgata Clementina (Latim) ---")
    url = "https://raw.githubusercontent.com/scrollmapper/bible_databases/master/sources/la/VulgClementine/VulgClementine.json"
    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
    with urllib.request.urlopen(req) as resp:
        data = json.loads(resp.read().decode("utf-8"))

    latin_names = [
        "Genesis", "Exodus", "Leviticus", "Numeri", "Deuteronomium", "Josue", "Judices", "Ruth",
        "I Samuelis", "II Samuelis", "I Regum", "II Regum", "I Paralipomenon", "II Paralipomenon",
        "I Esdrae", "Nehemiae", "Tobias", "Judith", "Esther", "Job", "Psalmi", "Proverbia",
        "Ecclesiastes", "Canticum Canticorum", "Sapientia", "Ecclesiasticus", "Isaias", "Jeremias",
        "Lamentationes", "Baruch", "Ezechiel", "Daniel", "Osee", "Joel", "Amos", "Abdias", "Jonas",
        "Michaeas", "Nahum", "Habacuc", "Sophonias", "Aggaeus", "Zacharias", "Malachias",
        "I Machabaeorum", "II Machabaeorum", "Sanctum Evangelium secundum Matthaeum",
        "Sanctum Evangelium secundum Marcum", "Sanctum Evangelium secundum Lucam",
        "Sanctum Evangelium secundum Joannem", "Actus Apostolorum", "Ad Romanos",
        "I ad Corinthios", "II ad Corinthios", "Ad Galatas", "Ad Ephesios", "Ad Philippenses",
        "Ad Colossenses", "I ad Thessalonicenses", "II ad Thessalonicenses", "I ad Timotheum",
        "II ad Timotheum", "Ad Titum", "Ad Philemonem", "Ad Hebraeos", "Epistola Jacobi",
        "I Petri", "II Petri", "I Joannis", "II Joannis", "III Joannis", "Epistola Judae", "Apocalypsis Joannis"
    ]

    db_path = os.path.join(OUTPUT_DIR, "biblia_vulgata.db")
    if os.path.exists(db_path):
        os.remove(db_path)

    conn = sqlite3.connect(db_path)
    c = conn.cursor()
    c.execute("""
        CREATE TABLE bible (
            testament TEXT NOT NULL,
            book_id INTEGER NOT NULL,
            book TEXT NOT NULL,
            chapter INTEGER NOT NULL,
            verse_id INTEGER NOT NULL,
            verse TEXT NOT NULL
        )
    """)

    for idx in range(73):
        b = data["books"][idx]
        book_id = idx + 1
        testament = "Old" if book_id <= 46 else "New"
        book_name = latin_names[idx]
        for ch in b["chapters"]:
            ch_num = ch["chapter"]
            for v in ch["verses"]:
                v_num = v["verse"]
                c.execute(
                    "INSERT INTO bible (testament, book_id, book, chapter, verse_id, verse) VALUES (?, ?, ?, ?, ?, ?)",
                    (testament, book_id, book_name, ch_num, v_num, clean_text(v.get("text", "")))
                )

    c.execute("CREATE INDEX idx_bible_book_chapter ON bible (book, chapter);")
    c.execute("CREATE INDEX idx_bible_book_id ON bible (book_id);")
    c.execute("CREATE INDEX idx_bible_testament ON bible (testament);")
    conn.commit()
    conn.close()

    gz_path = db_path + ".gz"
    gzip_file(db_path, gz_path)
    print(f"Vulgata Clementina gerada: {os.path.getsize(gz_path) / (1024*1024):.2f} MB")

def build_torres_amat():
    print("--- Gerando Biblia Platense / Torres Amat (Espanhol) ---")
    url = "https://raw.githubusercontent.com/scrollmapper/bible_databases/master/sources/es/SpaPlatense/SpaPlatense.json"
    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
    with urllib.request.urlopen(req) as resp:
        data = json.loads(resp.read().decode("utf-8"))

    spanish_names = [
        "Génesis", "Éxodo", "Levítico", "Números", "Deuteronomio", "Josué", "Jueces", "Rut",
        "1 Samuel", "2 Samuel", "1 Reyes", "2 Reyes", "1 Crónicas", "2 Crónicas", "Esdras", "Nehemías",
        "Tobías", "Judit", "Ester", "Job", "Salmos", "Proverbios", "Eclesiastés", "Cantar de los Cantares",
        "Sabiduría", "Eclesiástico", "Isaías", "Jeremías", "Lamentaciones", "Baruc", "Ezequiel", "Daniel",
        "Oseas", "Joel", "Amós", "Abdías", "Jonás", "Miqueas", "Nahúm", "Habacuc", "Sofonías", "Ageo",
        "Zacarías", "Malaquías", "1 Macabeos", "2 Macabeos", "San Mateo", "San Marcos", "San Lucas",
        "San Juan", "Hechos de los Apóstoles", "Romanos", "1 Corintios", "2 Corintios", "Gálatas",
        "Efesios", "Filipenses", "Colosenses", "1 Tesalonicenses", "2 Tesalonicenses", "1 Timoteo",
        "2 Timoteo", "Tito", "Filemón", "Hebreos", "Santiago", "1 Pedro", "2 Pedro", "1 Juan",
        "2 Juan", "3 Juan", "Judas", "Apocalipsis"
    ]

    db_path = os.path.join(OUTPUT_DIR, "biblia_torres_amat.db")
    if os.path.exists(db_path):
        os.remove(db_path)

    conn = sqlite3.connect(db_path)
    c = conn.cursor()
    c.execute("""
        CREATE TABLE bible (
            testament TEXT NOT NULL,
            book_id INTEGER NOT NULL,
            book TEXT NOT NULL,
            chapter INTEGER NOT NULL,
            verse_id INTEGER NOT NULL,
            verse TEXT NOT NULL
        )
    """)

    for idx in range(73):
        b = data["books"][idx]
        book_id = idx + 1
        testament = "Old" if book_id <= 46 else "New"
        book_name = spanish_names[idx]
        for ch in b["chapters"]:
            ch_num = ch["chapter"]
            for v in ch["verses"]:
                v_num = v["verse"]
                c.execute(
                    "INSERT INTO bible (testament, book_id, book, chapter, verse_id, verse) VALUES (?, ?, ?, ?, ?, ?)",
                    (testament, book_id, book_name, ch_num, v_num, clean_text(v.get("text", "")))
                )

    c.execute("CREATE INDEX idx_bible_book_chapter ON bible (book, chapter);")
    c.execute("CREATE INDEX idx_bible_book_id ON bible (book_id);")
    c.execute("CREATE INDEX idx_bible_testament ON bible (testament);")
    conn.commit()
    conn.close()

    gz_path = db_path + ".gz"
    gzip_file(db_path, gz_path)
    print(f"Biblia Torres Amat gerada: {os.path.getsize(gz_path) / (1024*1024):.2f} MB")

def main():
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    build_matos_soares()
    build_douay_rheims()
    build_vulgata()
    build_torres_amat()
    print("Todas as versões foram geradas e comprimidas com sucesso!")

if __name__ == "__main__":
    main()

