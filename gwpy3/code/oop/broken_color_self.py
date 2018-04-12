class Color(object):
    """An RGB color, with red, green and blue components."""
    
    def lightness(self):
        """Return the lightness of this color."""
        # Fails: no such variables 'red', 'green', and 'blue'
        strongest = max(red, green, blue)
        weakest   = min(red, green, blue)
        return 0.5 * (strongest + weakest) / 255
