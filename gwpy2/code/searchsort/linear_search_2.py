def linear_search(lst, value):
    """ (list, object) -> int

    … Exactly the same docstring goes here …
    """

    for i in range(len(lst)):
        if lst[i] == value:
            return i

    return -1
