"""import requests
from bs4 import BeautifulSoup
import sqlite3
import unicodedata

baseurl = "https://escriva.org"
url = "https://escriva.org/pt-br/"
headers = {"User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36"}

response = requests.get(url, headers=headers)
soup = BeautifulSoup(response.text, "html.parser")

for livro, link in zip(soup.select(".card-texts .card-title")[:1], soup.select(".books-grid > a")[:1]):
    conn = sqlite3.connect(f"../../assets/books/{link.attrs["href"].split('/')[-2]}.db")
    cursor = conn.cursor()

    response = requests.get(baseurl + link.attrs["href"], headers=headers)
    soup = BeautifulSoup(response.text, "html.parser")

    for index, (chapter, link) in enumerate(zip(soup.select(".cap-title"), soup.select("#contenido .pointbook"))):  # "#contenido .pointbook", "#contenido .homilybook", "#contenido .viarosbook", "#contenido .others"
        chapter_name = unicodedata.normalize('NFKC', chapter.text)
        cursor.execute(f"CREATE TABLE IF NOT EXISTS index (letter TEXT, subject TEXT, subject_2 TEXT, numbers TEXT)")

        response = requests.get(baseurl + link.attrs["href"], headers=headers)
        soup = BeautifulSoup(response.text, "html.parser")

        if chapter_name == "Prólogo do autor":
            cursor.execute(f"INSERT INTO index VALUES (?, ?, ?, ?)", (index, chapter_name, 0, None))
            
        else:
            for number in soup.select(".points a"):
                response = requests.get(baseurl + number.attrs["href"], headers=headers)
                soup = BeautifulSoup(response.text, "html.parser")
                content = "\n".join([p.get_text(strip=True) for p in soup.select("p")[:-1]])
                #cursor.execute(f"UPDATE book SET content = ? WHERE chapter_id = ? AND content_id = ?", (content, index, number.text))
                cursor.execute(f"INSERT INTO book VALUES (?, ?, ?, ?)", (index, chapter_name, number.text, content))
                print(chapter_name, "-", number.text, end='\r')
    conn.commit()
    conn.close()

"""



import requests
from bs4 import BeautifulSoup
import sqlite3
import json
import unicodedata


baseurl = "https://escriva.org"
url = "https://escriva.org/pt-br/subject-index/camino/"
headers = {"User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36"}

response = requests.get(url, headers=headers)
soup = BeautifulSoup(response.text, "html.parser")

dictLetters = {}
for letter in soup.select(".abc-letter a"):
    dictLetters[letter.text] = {}


count = -2
for i in range(224):
    lista = []
    lengh = len(soup.select(f".lista-materias div:nth-child({i}) > span"))
    if lengh == 0:
        count += 1
    if lengh == 1:
        for subject in soup.select(f".lista-materias div:nth-child({i}) > span")[0:1]:
            lista.append(subject.text)

        print(lista)
        for element in lista:
            dictLetters[lista[0][0].upper()].update({lista[0]: {}})

    else:
        for subject in soup.select(f".lista-materias div:nth-child({i}) > span")[0:lengh]:
            lista.append(subject.text)

        print(lista)
        for index, element in enumerate(lista):
            if dictLetters[lista[0][0].upper()].get(lista[0]) is None: 
                dictLetters[lista[0][0].upper()] .update({lista[0]: {}})
            else: 
                dictLetters[lista[0][0].upper()][lista[0]].update({element: {}})

with open("./caminho_index.json", "w") as file:
    json.dump(dictLetters, file, indent=4)



"""import requests
from bs4 import BeautifulSoup
import sqlite3
import unicodedata

baseurl = "https://escriva.org"
url = "https://escriva.org/pt-br/subject-index/camino/"
headers = {"User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36"}

response = requests.get(url, headers=headers)
soup = BeautifulSoup(response.text, "html.parser")

conn = sqlite3.connect(f"../../assets/books/caminho.db")
cursor = conn.cursor()

cursor.execute("SELECT DISTINCT subject FROM indice")

for subject in cursor.fetchall():
    uniform = unicodedata.normalize('NFD', subject[0])
    woaccent = ''.join([c for c in uniform if not unicodedata.combining(c)])
    main = woaccent.casefold().replace(' ', '-')
    #print(main)
    url = f"https://escriva.org/pt-br/subject-index/camino/{main}/"
    response = requests.get(url, headers=headers)
    soup = BeautifulSoup(response.text, "html.parser")

    cursor.execute("SELECT subject_2 FROM indice WHERE subject = ?", (subject[0],))

    for subject2, listpoinst in zip(cursor.fetchall(), soup.select(".point-list")):
        lpoints = []
        for element in listpoinst.find_all('a'):
            lpoints.append(element.text)
        #print(lpoints)
        print(lpoints, subject2)
        if lpoints == []:
            cursor.execute(f"UPDATE indice SET numbers = ? WHERE subject_2 = ?", ("None", subject2[0]))
        else:
            cursor.execute(f"UPDATE indice SET numbers = ? WHERE subject_2 = ?", (", ".join(lpoints), subject2[0]))

    conn.commit()

conn.close()"""