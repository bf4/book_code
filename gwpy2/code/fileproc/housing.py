def housing(reader):
    """ (file open for reading) -> tuple of (float, float)

    Return a tuple containing the the differences between the housing starts
    and construction contracts in 1983 and in 1984 from reader.
    """

    # The monthly housing starts, in thousands of units.
    starts = []

    # The construction contracts, in millions of dollars.
    contracts = []

    # Read the file, populating the lists.
    for line in reader:
        start, contract, rate = line.split()
        starts.append(float(start))
        contracts.append(float(contract))

    return (sum(starts[12:24]) - sum(starts[0:12]),
            sum(contracts[12:24]) - sum(contracts[0:12]))

if __name__ == "__main__":
    with open('housing.dat', 'r') as input_file:
        print(housing(input_file))
