>>> cur.execute('''SELECT Country FROM PopByCountry 
                   WHERE (ABS(Population - Population) < 1000)''')
<sqlite3.Cursor object at 0x102e3e490>
>>> cur.fetchall()
[('China',), ('DPR Korea',), ('Hong Kong (China)',), ('Mongolia',), 
('Republic of Korea',), ('Taiwan',), ('Bahamas',), ('Canada',), 
('Greenland',), ('Mexico',), ('United States',)]
