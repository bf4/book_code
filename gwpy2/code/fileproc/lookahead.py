def read_all_molecules(reader):
    """ (file open for reading) -> list

    Read zero or more molecules from reader,
    returning a list of the molecules read.
    """

    result = []
    line = reader.readline()
    while line:
        molecule, line = read_molecule(reader, line)
        result.append(molecule)
		
    return result
