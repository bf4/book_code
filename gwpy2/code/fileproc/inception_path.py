import os
tmp = open('tmp.py', 'r')
print os.path.realpath(tmp.name)
