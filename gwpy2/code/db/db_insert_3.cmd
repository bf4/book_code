>>> countries = [("Eastern Asia", "DPR Korea", 24056), ("Eastern Asia", 
"Hong Kong (China)", 8764), ("Eastern Asia", "Mongolia", 3407), ("Eastern 
Asia", "Republic of Korea", 41491), ("Eastern Asia", "Taiwan", 1433), 
("North America", "Bahamas", 368), ("North America", "Canada", 40876), 
("North America", "Greenland", 43), ("North America", "Mexico", 126875), 
("North America", "United States", 493038)]
>>> for c in countries:
...   cur.execute('INSERT INTO PopByCountry VALUES (?, ?, ?)', (c[0], c[1], c[2]))
... 
>>> con.commit()
