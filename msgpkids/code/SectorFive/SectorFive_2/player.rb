#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---
#SectorFive_2
class Player
  ROTATION_SPEED = 3
  ACCELERATION = 2
  FRICTION = 0.9

  def initialize(window)
    @x = 200
    @y = 200 
    @angle = 0
    @image = Gosu::Image.new(window,'images/ship.png',false)
    @velocity_x = 0
    @velocity_y = 0
    @radius = 20
    @window = window
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
  def turn_right
    @angle += ROTATION_SPEED
  end

  def turn_left
    @angle -= ROTATION_SPEED
  end
  def accelerate
    @velocity_x += Gosu.offset_x(@angle, ACCELERATION)
    @velocity_y += Gosu.offset_y(@angle, ACCELERATION)
  end
  def move
    @x += @velocity_x
    @y += @velocity_y
    @velocity_x *= FRICTION
    @velocity_y *= FRICTION
    if @x > @window.width - @radius
      @vx = 0
      @x = @window.width - @radius
    end
    if @x < @radius
      @vx = 0
      @x = @radius
    end
    if @y > @window.height - @radius
      @vy = 0
      @y = @window.height - @radius
    end
  end
end
