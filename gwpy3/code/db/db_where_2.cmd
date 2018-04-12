>>> cur.execute('''SELECT Region FROM PopByRegion
                   WHERE Population > 1000000 AND Region < "L"''')
<sqlite3.Cursor object at 0x102e3e490>
>>> cur.fetchall()
[('Eastern Asia',)]
