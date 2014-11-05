""" Functions for working with temperatures."""

def to_celsius(t):
    """ Convert Fahrenheit to Celsius."""
    return round((t - 32.0) * 5.0 / 9.0)

def above_freezing(t):
    """ True if temperature in Celsius is above freezing, False otherwise."""
    return t > 0
