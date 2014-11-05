class Color(object):
    """An RGB color, with red, green and blue components."""

    def __init__(self, r, g, b):
        """A new color with red value r, green value g, and blue value b.  All
        components are integers in the range 0-255."""

        self.red = r
        self.green = g
        self.blue = b
