input_file = open('hopedale.txt', 'r')
for line in input_file:
    line = line.strip()
    print line
input_file.close()
