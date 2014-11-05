def average(values):
    """ (list of number) -> number
	
    Return the average of the numbers in values.  Some items in values are
    None, and they are not counted toward the average.
	
    >>> average([20, 30])
    25.0
    >>> average([None, 20, 30])
    25.0
    """
	
    count = 0  # The number of values seen so far.
    total = 0  # The sum of the values seen so far.
    for value in values:
        if value is not None:
            total += value
			
        count += 1
		
    return total / count

if __name__ == '__main__':
    import doctest
    doctest.testmod()
