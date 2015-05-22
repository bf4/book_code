#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---
require 'gosu'

class WhackARuby < Gosu::Window
  def initialize
    super 800,600,false
    self.caption = "Whack the Ruby!"
    @image = Gosu::Image.new(self,'ruby.png',false)
    @x = 200
    @y = 200
    @width = 50
    @height = 43
    @vx = 5
    @vy = 5
    @visible = 0
  end
  def update
    @x += @vx
    @y += @vy

    if @x + @width/2 > 800 or @x - @width/2 < 0
      @vx *= -1
    end
    if @y + @height/2 > 600 or @y - @height/2 < 0
      @vy *= -1
    end
  end
  def draw
    @image.draw(@x-@width/2, @y-@height/2,1) if @visible > 0
  end
end

window = WhackARuby.new
window.show