#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---
module Gosu
  class Camera
    attr_reader :x_offset,:y_offset
    def initialize(space_height, window_height, space_width, window_width)
      @space_height = space_height
      @window_height = window_height
      @space_width = space_width
      @window_width = window_width
      @x_offset_max = space_width - window_width
      @y_offset_max = space_height - window_height
    end
    def center_on(sprite, right_margin, bottom_margin)
      @x_offset = sprite.x - @window_width + right_margin
      @y_offset = sprite.y - @window_height + bottom_margin
      @x_offset = @x_offset_max if @x_offset > @x_offset_max
      @x_offset = 0 if @x_offset < 0
      @y_offset = @y_offset_max if @y_offset > @y_offset_max
      @y_offset = 0 if @y_offset < 0
    end
    def shake
      @x_offset += rand(9) - 4
      @y_offset += rand(9) - 4
    end
  end
  class Image
    def draw_with_camera(x,y,z,camera,factor_x = 1, factor_y = 1, 
                         color = 0xffffffff, mode = :default)
      draw(x-camera.x_offset,y-camera.y_offset,
           z,factor_x, factor_y,color, mode)
    end
    def draw_rot_with_camera(x,y,z,angle,camera,center_x = 0.5, 
			                  center_y=0.5,factor_x = 1.0, factor_y = 1.0,
			                  color = 0xffffffff,mode = :default)
      draw_rot(x-camera.x_offset,y-camera.y_offset,z,angle,
               center_x, center_y,factor_x, factor_y, color, mode)
    end
  end
end
