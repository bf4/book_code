from typing import List

def running_sum(L: List[float]) -> None:
    """Modify L so that it contains the running sums of its original items.

    >>> L = [4, 0, 2, -5, 0]
    >>> running_sum(L)
    >>> L
    [4, 4, 6, 1, 1]
    """

    for i in range(1, len(L)):
        L[i] = L[i - 1] + L[i]
