def count_fragments(fragment, dna):
    """ (str, str) -> int
    
    Return the number of times fragment occurs in dna.
    
    >>> count_fragments('a', 'actg')
    1
    >>> count_fragments('c', 'cact')
    2
    """
    
    count = -1
    last_match = 0

    while last_match != -1:
        count += 1
        last_match = dna.find(fragment, last_match)
    
    return count
