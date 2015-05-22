#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---
class Credit
  SPEED = 1
  attr_reader :y

  def initialize(window, text, x, y)
    @x = x
    @y = @initial_y = y

    @text = text
    @font = Gosu::Font.new(window, 'system', 24)
  end
  def move
    @y -= SPEED
  end

  def draw
    @font.draw(@text, @x, @y, 1)
  end

  def reset
    @y = @initial_y
  end
end
