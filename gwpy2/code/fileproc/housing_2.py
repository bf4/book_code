def read_housing_data(r):
    """ Read housing data from reader r, returning lists of starts,
    contracts, and rates."""

    starts = []
    contracts = []
    rates = []

    for line in r:
        start, contract, rate = line.split()
        starts.append(float(start))
        contracts.append(float(contract))
        rates.append(rate)

    return (starts, contracts, rates)

def process_housing_data(starts, contracts):
    """ Return the difference between the housing starts and
    construction contracts in 1983 and in 1984."""

    return (sum(starts[12:24]) - sum(starts[0:12]),
            sum(contracts[12:24]) - sum(contracts[0:12]))

if __name__ == "__main__":
    with open('housing.dat', "r") as input_file:
        starts, contracts, rates = read_housing_data(input_file)

    print(process_housing_data(starts, contracts))
