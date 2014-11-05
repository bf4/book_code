with open('hopedale.txt', 'r') as hopedale_file:

    # Read the description line.
    hopedale_file.readline()

    # Keep reading comment lines until we read the first piece of data.
    data = hopedale_file.readline().strip()
    while data.startswith('#'):
        data = hopedale_file.readline().strip()

    # Now we have the first piece of data.  Accumulate the total number of
    # pelts.
    total_pelts = int(data)

    # Read the rest of the data.
    for data in hopedale_file:
        total_pelts = total_pelts + int(data.strip())

print("Total number of pelts:", total_pelts)
