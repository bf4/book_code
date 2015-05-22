#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---

require 'gosu'
class Square
  attr_reader :row, :col, :number, :color
  def initialize(window, col, row, color)
    @@colors ||= {red:Gosu::Color.argb(0xaaff0000), 
                green:Gosu::Color.argb(0xaa00ff00), 
                blue:Gosu::Color.argb(0xaa0000ff)}
  	@@font ||= Gosu::Font.new(window, 'System', 72)
    @@window ||= window
    @row = row
    @col = col
    @color = color
    @number = 1
  end
  def clear
    @number = 0
  end

  def set(color, number)
    @color = color
    @number = number
  end
  def draw
    if @number != 0
      x1 = 22 + col * 100
      y1 = 22 + row * 100
      x2 = x1 + 96
      y2 = y1
      x3 = x2
      y3 = y2 + 96
      x4 = x1
      y4 = y3
      c = @@colors[@color]
      @@window.draw_quad(x1,y1,c,x2,y2,c,x3,y3,c,x4,y4,c,2)
      x_center = x1 + 48
      x_text = x_center - @@font.text_width("#{@number}")/2
      y_text = y1 + 14
      @@font.draw("#{@number}",x_text, y_text, 1)
    end
  end

end



