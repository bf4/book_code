#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---
class Explosion
  attr_reader :finished
  def initialize(window, x, y)
    @x = x
    @y = y
    @radius = 30

    @images = Gosu::Image.load_tiles(window, "images/explosions.png", 60,60, false)
    
    @image_index = 0
    @finished = false
  end
  def draw
    if @image_index < @images.count
      @images[@image_index].draw(@x - @radius, @y - @radius, 2)
      @image_index += 1
    else
      @finished = true
    end
  end
end
