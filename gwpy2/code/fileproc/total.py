def sum_number_pairs(input_file, output_filename):
    """ (file open for reading, str) -> NoneType

    Read the data from input_file, which contains two floats per line
    separated by a space.  Open file named output_file and, for each line in
    input_file, write a line to the output file that contains the two floats
    from the corresponding line of input_file plus a space and the sum of the
    two floats.
    """

    with open(output_filename, 'w') as output_file:
        for number_pair in input_file:
            number_pair = number_pair.strip()
            operands = number_pair.split()
            total = float(operands[0]) + float(operands[1])
            new_line = '{0} {1}\n'.format(number_pair, total)
            output_file.write(new_line)
