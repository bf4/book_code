#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---

class Boulder
  attr_reader :body, :width, :height
  def initialize(window, x, y)
    space = window.space
    @camera = window.camera
    @height = 32
		@width = 32
		@window = window
		@body = CP::Body.new(400,4000)
		@body.object = self
		@body.p = CP::Vec2.new(x, y)
		@body.v_limit = 250
		@bounds = [CP::Vec2.new(-13,-6),
		           CP::Vec2.new(-16,-4),
		           CP::Vec2.new(-16,6),
		           CP::Vec2.new(-3,12),
		           CP::Vec2.new(8,12),
		           CP::Vec2.new(13,10),
		           CP::Vec2.new(16,3),
		           CP::Vec2.new(16,-4),
		           CP::Vec2.new(10,-9),
		           CP::Vec2.new(2,-11)]
		@shape = CP::Shape::Poly.new(@body, @bounds, CP::Vec2.new(0,0))
		@shape.u = 0.7
		@shape.e = 0.95
		space.add_body(@body)
		space.add_shape(@shape)
		@image = Gosu::Image.new(@window, "images/boulder.png",false)
		@body.apply_impulse(CP::Vec2.new(rand(100000) - 50000, 100000),
		                    CP::Vec2.new(rand*0.8 - 0.4,0))
	end
  def draw
    @image.draw_rot_with_camera(@body.p.x, @body.p.y, 1, 
                                @body.angle * (180.0/Math::PI),@camera)
  end
  def quake
  	@body.apply_impulse(CP::Vec2.new(rand(100000) - 50000, 100000),
		                    CP::Vec2.new(rand*0.8 - 0.4,0))
  end
end

