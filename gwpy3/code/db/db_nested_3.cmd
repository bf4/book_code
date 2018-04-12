>>> cur.execute('''
SELECT DISTINCT Region 
FROM PopByCountry 
WHERE Region NOT IN 
    (SELECT DISTINCT Region 
     FROM PopByCountry 
     WHERE (PopByCountry.Population = 8764))
''')
<sqlite3.Cursor object at 0x102e3e490>
>>> cur.fetchall()
[('North America',)]
