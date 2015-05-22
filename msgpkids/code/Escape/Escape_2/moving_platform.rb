#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---
class MovingPlatform
  attr_reader :body,:width,:height
  def initialize(window, x, y, range, direction)
    #direction will be :horizontal or :vertical
  	@space = window.space
  	@window = window
    @camera = window.camera
    @direction = direction
    @x_center = x
    @y_center = y
  	@body = CP::Body.new(100000, 100.0/0)
  	@body.object = self
    @width = 96
    @height = 16
    if @direction == :horizontal
  	  @body.p = CP::Vec2.new(x + range + 100, y)
      @move = :right
    else
      @body.p = CP::Vec2.new(x, y + range + 100)
      @move = :down
    end
    @body.v_limit=40
    @range = range
  	@bounds = [CP::Vec2.new(-48,-8), CP::Vec2.new(-48,8), CP::Vec2.new(48,8), CP::Vec2.new(48, -8)]
  	@shape = CP::Shape::Poly.new(@body, @bounds, CP::Vec2.new(0,0))
  	@shape.collision_type = :platform
    @shape.u = 0.9
    @shape.e = 0.2
    @space.add_body(@body)
    @space.add_shape(@shape)
    @image = Gosu::Image.new(window, "images/platform.png",false)
    @body.apply_force(CP::Vec2.new(0,-10000000), CP::Vec2.new(0,0))
   
  end
  def draw
  	@image.draw_rot_with_camera(@body.p.x, @body.p.y , 1, 0,@camera)
    #draw_polygon
  end

  def move
    if @direction == :horizontal
      if @body.p.x > @x_center + @range and @move != :left
        @body.reset_forces
        @body.apply_force(CP::Vec2.new(0,-10000000), CP::Vec2.new(0,0))
        @body.apply_force(CP::Vec2.new(-5000000,0), CP::Vec2.new(0,0))
        @move = :left
      
      elsif @body.p.x < @x_center - @range and @move != :right
        @body.reset_forces
        @body.apply_force(CP::Vec2.new(0,-10000000), CP::Vec2.new(0,0))
        @body.apply_force(CP::Vec2.new(5000000,0), CP::Vec2.new(0,0))
        @move = :right
      end
      @body.p.y = @y_center
    else
      if @body.p.y > @y_center + @range and @move != :up
        @body.reset_forces
        @body.apply_force(CP::Vec2.new(0,-15000000), CP::Vec2.new(0,0))
        @move = :up
      
      elsif @body.p.y < @y_center - @range and @move != :down
        @body.reset_forces
        @body.apply_force(CP::Vec2.new(0,-5000000), CP::Vec2.new(0,0))
        @move = :down

      end
      @body.p.x = @x_center
    end
  end
end