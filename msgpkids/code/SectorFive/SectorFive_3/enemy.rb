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
    @width = 40
    @height = 33
    @window = window
    @x = rand(@window.width-@width)
    @y = 0
    @image = Gosu::Image.new(window,'images/enemy.png',false)
    @radius = 20
  end

  def draw
    @image.draw(@x - @width/2, @y - @height/2, 1)
  end

  def move
    @y += SPEED
  end
end