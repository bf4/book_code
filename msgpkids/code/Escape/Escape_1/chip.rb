#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---
class Chip
  attr_accessor :off_ground
  def initialize(window, x, y)
    @window = window
    space = window.space
    @images = Gosu::Image.load_tiles(window,"images/chip.png", 40, 65, false)
    @body = CP::Body.new(50, 100/0.0)
    @body.object = self
    @body.p = CP::Vec2.new(x,y)
    @body.v_limit = 200
    @bounds = [CP::Vec2.new(-10,-32),
               CP::Vec2.new(-10,32),
               CP::Vec2.new(10,32),
               CP::Vec2.new(10,-32) ]
    @shape = CP::Shape::Poly.new(@body, @bounds, CP::Vec2.new(0,0))
    @shape.u = 0.7
    @shape.e = 0.2
    space.add_body(@body)
    space.add_shape(@shape)
    @action = :stand
    @image_index = 0
    @off_ground = true
  end
  def x
    @body.p.x
  end
  def check_footing(things)
    @off_ground = true
    things.each do |thing|
      @off_ground = false if touching?(thing)
    end
    if @body.p.y > 765
      @off_ground = false
    end
  end
  def draw
    case @action
    when :run_right
      @images[@image_index].draw_rot(@body.p.x, @body.p.y, 0,2)
      @image_index = (@image_index + 0.2) % 7
    when :stand, :jump_right
      @images[0].draw_rot(@body.p.x, @body.p.y, 2, 1)
    when :run_left
      @images[@image_index].draw_rot(@body.p.x, @body.p.y, 0,2,0.5,0.5,-1,1)
      @image_index = (@image_index + 0.2) % 7
    when :jump_left
      @images[0].draw_rot(@body.p.x, @body.p.y, 0,2,0.5,0.5,-1,1)
    else
      @images[0].draw_rot(@body.p.x, @body.p.y, 2, 1)
    end
  end
  def move_right
    if off_ground
      @action = :jump_right
      @body.apply_impulse(CP::Vec2.new(30,0), CP::Vec2.new(0,0))
    else
      @action = :run_right
      @body.apply_impulse(CP::Vec2.new(300,0), CP::Vec2.new(0,0))
    end
  end
  def move_left
    if off_ground
      @action = :jump_left
      @body.apply_impulse(CP::Vec2.new(-30,0), CP::Vec2.new(0,0))
    else
      @action = :run_left
      @body.apply_impulse(CP::Vec2.new(-300,0), CP::Vec2.new(0,0))
    end
  end
    
  def stand
    @action = :stand if not off_ground
  end
  def jump
    if off_ground
      @body.apply_impulse(CP::Vec2.new(0,-1200), CP::Vec2.new(0,0))
    else
      @body.apply_impulse(CP::Vec2.new(0,-36000), CP::Vec2.new(0,0))
      if @action == :left
        @action = :jump_left
      else
        @action = :jump_right
      end
    end
  end
  def touching?(footing)
    x_diff = (@body.p.x - footing.body.p.x ).abs
    y_diff = (@body.p.y + 30 - footing.body.p.y ).abs
    x_diff < 12 + footing.width/2 and y_diff < 5 + footing.height/2
  end
end
