class Rectangle(object):
    """Represent a rectangular section of an image."""

    def __init__(self, x0, y0, x1, y1):
        """ (Rectangle, int, int, int, int) -> NoneType

        Create a rectangle with non-zero area. (x0,y0) is the
        lower left corner, (x1,y1) the upper right corner.
        """

        self.x0 = x0
        self.y0 = y0
        self.x1 = x1
        self.y1 = y1

    def area(self):
        """ (Rectangle) -> number

        Return the area of the rectangle.
        """

        return (self.x1 - self.x0) * (self.y1 - self.y0)

    def contains(self, x, y):
        """ (Rectangle, int, int) -> bool

        Return True is (x,y) point is inside a rectangle,
        and False otherwise.
        """

        return (self.x0 <= x <= self.x1) and \
               (self.y0 <= y <= self.y1)
