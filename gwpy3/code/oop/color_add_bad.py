class Color(object):
    ...other definitions as before...

    def __add__(self, other_color):
        """This is a bad way to define this method."""

        self.red += other_color.red
        self.green += other_color.green
        self.blue += other_color.blue
        return self
