from ms import mergesort, merge
import nose

def run_mergesort(original, expected):
    """Sort list original and compare it to list expected."""
    mergesort(original)
    assert original == expected

def run_merge(L1, L2, expected):
    """Merge list original[b1:e1] with original[b2:e2] and compare it to list
    expected."""
    result = merge(L1, L2)
    assert result == expected
    
def test_merge_empty():
    """Test merging a 0-item list."""
    run_merge([], [], [])

def test_merge_one():
    """Test merging a 1-item list and a 1-item list."""
    run_merge([2], [1], [1, 2])

def test_merge_one_two():
    """Test merging a 2-item list and a 1-item list."""
    L = [1, 3, 2]
    run_merge([1, 3], [2], [1, 2, 3])

def test_merge_two_two():
    """Test merging a 2-item list and a 2-item list."""
    run_merge([1, 3], [2, 4], [1, 2, 3, 4])

def test_merge_two_two_same():
    """Test merging a 2-item list and a 2-item list where they have common
    elements."""
    run_merge([1, 3], [1, 3], [1, 1, 3, 3])

def test_empty():
    """Test sorting empty list."""
    run_mergesort([], [])

def test_one():
    """Test sorting a list of one value."""
    run_mergesort([1], [1])

def test_two_ordered():
    """Test sorting an already-sorted list of two values."""
    run_mergesort([1, 2], [1, 2])

def test_two_reversed():
    """Test sorting a reverse-ordered list of two values."""
    run_mergesort([2, 1], [1, 2])

def test_three_identical():
    """Test sorting a list of three equal values."""
    run_mergesort([3, 3, 3], [3, 3, 3])

def test_three_split():
    """Test sorting a list with an odd value out."""
    run_mergesort([3, 0, 3], [0, 3, 3])

if __name__ == '__main__':
    nose.runmodule()
