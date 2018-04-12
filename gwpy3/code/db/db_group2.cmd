>>> cur.execute('''SELECT SUM (Population) FROM PopByCountry 
                   WHERE Region = "North America"''')
<sqlite3.Cursor object at 0x102a3bb20>
>>> cur.fetchall()
[(661200,)]
>>> cur.execute('''SELECT SUM (Population) FROM PopByCountry
                   WHERE Region = "Eastern Asia"''')
<sqlite3.Cursor object at 0x102a3bb20>
>>> cur.fetchall()
[(1364389,)]