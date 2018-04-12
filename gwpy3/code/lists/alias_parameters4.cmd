>>> from typing import List, Any
>>> def remove_last_item(L: List[Any]) -> None:
...     """Remove the last item from L.
...
...     Precondition: len(L) >= 0
...
...     >>> remove_last_item([1, 3, 2, 4])
...     """
...     del L[-1]
