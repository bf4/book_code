def linear_search(lst, value):
    """ (list, object) -> int

    … Exactly the same docstring goes here …
    """

    # Add the sentinel.
    lst.append(value)

    i = 0

    # Keep going until we find value.
    while lst[i] != value:
        i = i + 1

    # Remove the sentinel.
    lst.pop()

    # If we reached the end of the list we didn't find value.
    if i == len(lst):
        return -1
    else:
        return i
