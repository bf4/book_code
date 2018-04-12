from typing import Any

def linear_search(lst: list, value: Any) -> int:
    """… Exactly the same docstring goes here …
    """

    for i in range(len(lst)):
        if lst[i] == value:
            return i

    return -1
