input_file = open("hopedale.txt", "r")

# Skip the first line.
input_file.readline()

# Skip the comments.
line = input_file.readline()
while line.startswith('#'):
	line = input_file.readline()

# Now we want to process the rest of the lines.
for line in input_file:
    line = line.strip()
    print line
input_file.close()
