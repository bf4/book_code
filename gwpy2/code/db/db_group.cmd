>>> cur.execute('SELECT SUM (Population) FROM PopByCountry GROUP BY Region')
<sqlite3.Cursor object at 0x102e3e490>
>>> cur.fetchall()
[(1364389,), (661200,)]
