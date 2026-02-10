import json
import sqlite3
import os

def create_database():
    db_path = "assets/biblia_acf.sqlite"
    if os.path.exists(db_path):
        os.remove(db_path)

    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    # Create table matching existing schema
    # Columns confirmed: book, testament, chapter, verse_id, verse, book_id
    cursor.execute('''
        CREATE TABLE bible (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            book TEXT,
            chapter INTEGER,
            verse_id INTEGER,
            verse TEXT,
            testament TEXT,
            book_id INTEGER
        )
    ''')
    
    return conn, cursor

def load_json():
    with open("assets/acf.json", "r", encoding="utf-8-sig") as f:
        return json.load(f)

def get_testament(book_index):
    # 0-38 is Old Testament (39 books)
    # 39-65 is New Testament (27 books)
    if book_index < 39:
        return "Old"
    else:
        return "New"

def main():
    print("Converting acf.json to SQLite...")
    
    try:
        data = load_json()
    except FileNotFoundError:
        print("Error: assets/acf.json not found. Please download it first.")
        return

    conn, cursor = create_database()
    
    # Iterate through books
    # JSON structure is usually list of books, each with 'name', 'chapters' (list of lists of verses)
    # I need to verify strict structure of acf.json. 
    # Based on thiagobodruk/biblia structure:
    # [
    #   {
    #     "abbrev": "gn",
    #     "chapters": [
    #       [ "No princípio...", "E a terra..." ], ...
    #     ],
    #     "name": "Gênesis"
    #   }, ...
    # ]
    
    book_id_counter = 1
    
    for book_idx, book_data in enumerate(data):
        book_name = book_data.get("name")
        testament = get_testament(book_idx)
        
        chapters = book_data.get("chapters")
        
        print(f"Processing {book_name} ({testament})...")
        
        for chapter_idx, verses in enumerate(chapters):
            chapter_num = chapter_idx + 1
            
            for verse_idx, verse_text in enumerate(verses):
                verse_num = verse_idx + 1
                
                cursor.execute('''
                    INSERT INTO bible (book, chapter, verse_id, verse, testament, book_id)
                    VALUES (?, ?, ?, ?, ?, ?)
                ''', (book_name, chapter_num, verse_num, verse_text, testament, book_id_counter))
        
        book_id_counter += 1

    conn.commit()
    conn.close()
    print("Database assets/biblia_acf.sqlite created successfully.")

if __name__ == "__main__":
    main()
