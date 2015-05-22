#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---

class Enemy
  SPEED = 4
  attr_reader :x, :y, :radius
  def initialize(window)
    @y = 0
    @image = Gosu::Image.new(window,'images/enemy.png',false)
    @radius = 20
    @x = rand(window.width- 2 * @radius) + @radius
  end
  def draw
    @image.draw(@x - @radius, @y - @radius, 1)
  end
  def move
    @y += SPEED
  end
end
