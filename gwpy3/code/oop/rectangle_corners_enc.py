class Rectangle(object):
    """Represent a rectangular section of an image."""

    def __init__(self, x0, y0, x1, y1):
        # ...as before...

    def area(self):
        # ...as before...

    def contains(self, x, y):
        # ...as before...

    def get_min_x(self):
        """ (Rectangle) -> int

        Return the minimum X coordinate.
        """

        return self.x0

    def get_min_y(self):
        """ (Rectangle) -> int

        Return the minimum Y coordinate.
        """

        return self.y0

    def get_max_x(self):
        """ (Rectangle) -> int

        Return the maximum X coordinate.
        """

        return self.x1

    def get_max_y(self):
        """ (Rectangle) -> int

        Return the maximum Y coordinate.
        """

        return self.y1
