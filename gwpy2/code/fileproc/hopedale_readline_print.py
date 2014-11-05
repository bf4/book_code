with open('hopedale.txt', 'r') as hopedale_file:

    # Read the description line.
    hopedale_file.readline()

    # Keep reading comment lines until we read the first piece of data.
    data = hopedale_file.readline().rstrip()
    while data.startswith('#'):
        data = hopedale_file.readline().rstrip()

    # Now we have the first piece of data.
    print(data)

    # Read the rest of the data.
    for data in hopedale_file:
        print(data.rstrip())
