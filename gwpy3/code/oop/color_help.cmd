>>> help(Color)
Help on class Color in module color_full_distance:

class Color(__builtin__.object)
 |  An RGB color, with red, green and blue components.
 |  
 |  Methods defined here:
 |  
 |  __add__(self, other_color)
 |      Return a new Color made from adding the red, green, and blue
 |      components of this Color to Color other_color's components.
 |      If the sum is greater than 255, then the color is set to 255.
 |  
 |  __eq__(self, other_color)
 |      Return True if this Color's components are equal to Color
 |      other_color's components.
 |  
 |  __init__(self, r, g, b)
 |      A new color with red value r, green value g, and blue value b.  All
 |      components are integers in the range 0-255.
 |  
 |  __str__(self)
 |      Return a string representation of this Color in the form
 |      Color(red, green, blue).
 |  
 |  __sub__(self, other_color)
 |      Return a new Color made from subtracting the red, green, and blue
 |      components of this Color from Color other_color's components.
 |      If the difference is less than 0, then the color is set to 0.
 |  
 |  lightness(self)
 |      Return the lightness of this color.
 |  ----------------------------------------------------------------------
 |  Data descriptors defined here:
 |  
 |  __dict__
 |      dictionary for instance variables (if defined)
 |  
 |  __weakref__
 |      list of weak references to the object (if defined)