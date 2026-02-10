import sqlite3
import json
import os

def create_database(json_file, db_name, language):
    if os.path.exists(db_name):
        os.remove(db_name)

    conn = sqlite3.connect(db_name)
    cursor = conn.cursor()

    cursor.execute('''
        CREATE TABLE bible (
            book TEXT,
            testament TEXT,
            chapter INTEGER,
            verse_id INTEGER,
            verse TEXT,
            book_id INTEGER
        )
    ''')

    with open(json_file, 'r', encoding='utf-8-sig') as f:
        data = json.load(f)

    # Ordered list of books for mapping names if necessary, or validation
    # This list assumes standard Protestant canon order (Gen-Rev)
    # We will use this to assign book_id and testament
    
    english_books = [
        "Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy", "Joshua", "Judges", "Ruth", "1 Samuel", "2 Samuel",
        "1 Kings", "2 Kings", "1 Chronicles", "2 Chronicles", "Ezra", "Nehemiah", "Esther", "Job", "Psalms", "Proverbs",
        "Ecclesiastes", "Song of Solomon", "Isaiah", "Jeremiah", "Lamentations", "Ezekiel", "Daniel", "Hosea", "Joel",
        "Amos", "Obadiah", "Jonah", "Micah", "Nahum", "Habakkuk", "Zephaniah", "Haggai", "Zechariah", "Malachi",
        "Matthew", "Mark", "Luke", "John", "Acts", "Romans", "1 Corinthians", "2 Corinthians", "Galatians", "Ephesians",
        "Philippians", "Colossians", "1 Thessalonians", "2 Thessalonians", "1 Timothy", "2 Timothy", "Titus", "Philemon",
        "Hebrews", "James", "1 Peter", "2 Peter", "1 John", "2 John", "3 John", "Jude", "Revelation"
    ]

    spanish_books = [
        "Génesis", "Éxodo", "Levítico", "Números", "Deuteronomio", "Josué", "Jueces", "Rut", "1 Samuel", "2 Samuel",
        "1 Reyes", "2 Reyes", "1 Crónicas", "2 Crónicas", "Esdras", "Nehemías", "Ester", "Job", "Salmos", "Proverbios",
        "Eclesiastés", "Cantares", "Isaías", "Jeremías", "Lamentaciones", "Ezequiel", "Daniel", "Oseas", "Joel",
        "Amós", "Abdías", "Jonás", "Miqueas", "Nahúm", "Habacuc", "Sofonías", "Hageo", "Zacarías", "Malaquías",
        "Mateo", "Marcos", "Lucas", "Juan", "Hechos", "Romanos", "1 Corintios", "2 Corintios", "Gálatas", "Efesios",
        "Filipenses", "Colosenses", "1 Tesalonicenses", "2 Tesalonicenses", "1 Timoteo", "2 Timoteo", "Tito", "Filemón",
        "Hebreos", "Santiago", "1 Pedro", "2 Pedro", "1 Juan", "2 Juan", "3 Juan", "Judas", "Apocalipsis"
    ]
    
    book_names = english_books if language == 'en' else spanish_books

    print(f"Processing {json_file} for language {language}...")

    # Iterate strictly 0 to 65
    for i, book_data in enumerate(data):
        if i >= 66: break 
        
        book_id = i + 1
        book_name = book_names[i]
        
        # Verify if 'name' exists in JSON and matches broadly, otherwise use our list
        # JSON parsing: data is list of objects.
        # rvr.json had 'abbrev' but maybe not 'name'.
        
        testament = "Old" if book_id <= 39 else "New"
        
        chapters = book_data.get('chapters', [])
        
        for ch_idx, verses in enumerate(chapters):
            chapter_num = ch_idx + 1
            for v_idx, verse_text in enumerate(verses):
                verse_num = v_idx + 1
                
                cursor.execute(
                    'INSERT INTO bible (book, testament, chapter, verse_id, verse, book_id) VALUES (?, ?, ?, ?, ?, ?)',
                    (book_name, testament, chapter_num, verse_num, verse_text, book_id)
                )

    conn.commit()
    conn.close()
    print(f"Created {db_name} successfully.")

if __name__ == "__main__":
    create_database('assets/rvr.json', 'assets/biblia_rvr.db', 'es')
    try:
        create_database('assets/kjv.json', 'assets/biblia_kjv.db', 'en')
    except Exception as e:
        print(f"Failed to create KJV DB: {e}")
