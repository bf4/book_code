>>> from io import StringIO
>>> outfile = StringIO()
>>> outfile.write('1.3 3.4 4.7\n')
12
>>> outfile.write('2 4.2 6.2\n')
10
>>> outfile.write('-1 1 0.0\n')
9
>>> outfile.getvalue()
'1.3 3.4 4.7\n2 4.2 6.2\n-1 1 0.0\n'
