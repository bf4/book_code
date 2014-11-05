import sys

def process_file(reader):
    """ Read and print the contents of reader."""

    for line in reader:
        line = line.strip()
        print line

if __name__ == "__main__":
	input_file = open('hopedale.txt', 'r')
    process_file(input_file)
    input_file.close()
