#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
require 'grid'
require 'chunky_png'

class ColoredGrid < Grid
  def distances=(distances) 
    @distances = distances
    farthest, @maximum = distances.max 
  end

  def background_color_for(cell) 
    distance = @distances[cell] or return nil
    intensity = 255 * (@maximum - distance) / @maximum 
    ChunkyPNG::Color.rgb(0, intensity, 0) 
  end
end
