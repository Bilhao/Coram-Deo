#!/usr/bin/env python3
"""
Script to update Santo Rosário and Via Sacra content from new sources.
This script updates the local databases with enhanced content.
"""

import sqlite3
import os
import sys

def update_santo_rosario():
    """Update Santo Rosário content"""
    print("Updating Santo Rosário content...")
    
    db_path = "assets/books/santo_rosario.db"
    
    # Backup current content
    os.system(f"cp {db_path} {db_path}.backup")
    
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    try:
        # Check if we have introductory content
        cursor.execute("SELECT COUNT(*) FROM book WHERE chapter = 'Introdução'")
        if cursor.fetchone()[0] == 0:
            cursor.execute("""
                INSERT INTO book (chapter_id, chapter, content_id, content_name, content) 
                VALUES (0, 'Introdução', 1, 'Como rezar o Santo Rosário', 
                'O Santo Rosário é uma oração mariana tradicional que combina orações vocais com a meditação dos mistérios da vida de Jesus e Maria. Esta devoção, amada por São Josemaría Escrivá, nos convida a contemplar os principais momentos da Redenção, unidos ao Coração Imaculado de Maria.')
            """)
        
        # Add enhanced content for each mystery
        enhanced_content = {
            'Mistérios Gozosos ': 'Os Mistérios Gozosos contemplam os acontecimentos felizes da Encarnação e infância de Jesus, unidos à alegria de Maria.',
            'Mistérios Dolorosos ': 'Os Mistérios Dolorosos meditam sobre a Paixão de Cristo, acompanhando Maria na sua dor pela salvação da humanidade.',
            'Mistérios Gloriosos ': 'Os Mistérios Gloriosos celebram a Ressurreição de Jesus e a glorificação de Maria, antecipando nossa esperança eterna.',
            'Mistérios Luminosos ': 'Os Mistérios Luminosos, propostos por São João Paulo II, contemplam a vida pública de Jesus, luz do mundo.'
        }
        
        for chapter, description in enhanced_content.items():
            cursor.execute("SELECT content_id FROM book WHERE chapter = ? AND content_name = 'Introdução'", (chapter,))
            if not cursor.fetchone():
                cursor.execute("""
                    INSERT INTO book (chapter_id, chapter, content_id, content_name, content) 
                    VALUES ((SELECT MAX(chapter_id) FROM book WHERE chapter = ?) + 1, ?, 0, 'Introdução', ?)
                """, (chapter, chapter, description))
        
        conn.commit()
        print("Santo Rosário content updated successfully!")
        
    except Exception as e:
        print(f"Error updating Santo Rosário: {e}")
        # Restore backup
        os.system(f"cp {db_path}.backup {db_path}")
    finally:
        conn.close()

def update_via_sacra():
    """Update Via Sacra content"""
    print("Updating Via Sacra content...")
    
    db_path = "assets/books/via_sacra.db"
    
    # Backup current content
    os.system(f"cp {db_path} {db_path}.backup")
    
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    
    try:
        # Enhance the introduction
        cursor.execute("SELECT content FROM book WHERE chapter = 'Introdução'")
        result = cursor.fetchone()
        
        if result and len(result[0]) < 200:  # If introduction is too short, enhance it
            enhanced_intro = """A Via-Sacra é uma devoção que nos convida a acompanhar Jesus no seu caminho para o Calvário. 

Seguindo os ensinamentos de São Josemaría Escrivá, esta Via Sacra nos ajuda a meditar sobre o amor infinito de Cristo e a aplicar suas lições à nossa vida diária. 

Cada estação é uma oportunidade de crescer em santidade, de nos identificarmos com Cristo sofredor e de renovar nosso amor a Deus e ao próximo.

"Que a tua vida seja um louvor contínuo ao Senhor, uma oração constante. Tua conduta, exemplo; tuas palavras, doutrina; teu olhar, perdão; tua presença, oração; teu silêncio, pregação." - São Josemaría Escrivá"""
            
            cursor.execute("UPDATE book SET content = ? WHERE chapter = 'Introdução'", (enhanced_intro,))
        
        conn.commit()
        print("Via Sacra content updated successfully!")
        
    except Exception as e:
        print(f"Error updating Via Sacra: {e}")
        # Restore backup
        os.system(f"cp {db_path}.backup {db_path}")
    finally:
        conn.close()

def main():
    if len(sys.argv) > 1 and sys.argv[1] == "--update-content":
        update_santo_rosario()
        update_via_sacra()
    else:
        print("Use --update-content to update the databases")
        print("For now, using existing content with improvements")

if __name__ == "__main__":
    main()