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
    @velocity_x = 5
    @velocity_y = 5
    @visible = 0
    @hammer_image = Gosu::Image.new(self,'hammer.png', false)
    @hit = 0  
    @score = 0
    @font = Gosu::Font.new(self,"system",30)
    @playing = true
    @start_time = 0


  end
  def update
    if @playing 
      @x += @velocity_x
      @y += @velocity_y
      @visible -= 1
      @time_left = (100 - ((Gosu.milliseconds-@start_time)/1000)).to_s
      if (Gosu.milliseconds-@start_time) > 100000
        @playing = false
      end  
      if @x + @width/2 > 800 or @x - @width/2 < 0
        @velocity_x *= -1
      end
      if @y + @height/2 > 600 or @y - @height/2 < 0
        @velocity_y *= -1
      end
      if @visible < -10 and rand < 0.01
        @visible = 30
      end
      
    end
  end
  def button_down(id)
    if @playing
      if (id == Gosu::MsLeft)
        if Gosu.distance(mouse_x,mouse_y,@x,@y)<50 and @visible >= 0
          @hit = 1
          @score += 5
        else
          @hit = -1
          @score -= 1
        end
      end
    else
      if (id == Gosu::KbSpace)
        @playing = true
        @visible = -10
        @start_time = Gosu.milliseconds
        @score = 0
      end
    end
  end
  def draw

    if @hit == 0
      c = Gosu::Color::NONE
    elsif @hit == 1
      c = Gosu::Color::GREEN
    elsif @hit == -1
      c = Gosu::Color::RED
    end
    draw_quad(0,0,c,800,0,c,800,600,c,0,600,c)
    @hit = 0
    @image.draw(@x-@width/2, @y-@height/2,1) if @visible > 0 
    @hammer_image.draw(mouse_x-40, mouse_y-10, 1)
    @font.draw(@time_left,20,20,2)
    @font.draw(@score.to_s,700,20,2)

    if not @playing
       @font.draw("Game Over", 300,300,3)

       @font.draw("Press the Space Bar to Play Again", 175,350,3)

       @visible = 20
    end

  end

end

window = WhackARuby.new
window.show
