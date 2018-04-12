""" Display the lines of data.txt from the given starting line number to the
given end line number.

Usage: read_lines_range.py start_line end_line """

import sys

if __name__ == '__main__':
    
    # get the start and end line numbers
    start_line = int(sys.argv[1])
    end_line = int(sys.argv[2])
    
    # read the lines of the file and store them in a list
    data = open('data.txt', 'r')
    data_list = data.readlines()
    data.close()

    # display lines within start to end range    
    for line in data_list[start_line:end_line]:
        print(line.strip())
        