def find_two_smallest(L):
    """ (list of float) -> tuple of (int, int)

    Return a tuple of the indices of the two smallest values in list L.

    >>> find_two_smallest([809, 834, 477, 478, 307, 122, 96, 102, 324, 476])
    (6, 7)
    """
	
    # Examine each value in the list in order
    # Keep track of the indices of the two smallest values found so far
    # Update these values when a new smaller value is found
    # Return the two indices
