def lightness(color):
    """Return the lightness of color."""

    strongest = max(color.red, color.green, color.blue)
    weakest   = min(color.red, color.green, color.blue)
    return 0.5 * (strongest + weakest) / 255
