#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---
require 'gosu'
require_relative 'game'

class Twelve < Gosu::Window

  def initialize
    super 640,640,false
    self.caption = "Twelve"
    @game = Game.new(self)
  end
  def needs_cursor?
    true
  end
  def button_up(id)
    if id == Gosu::MsLeft
      @game.handle_mouse_up(mouse_x, mouse_y)
    end
  end
  def button_down(id)
    if id == Gosu::MsLeft
       @game.handle_mouse_down(mouse_x, mouse_y)
    end
    if id == Gosu::KbR and button_down?(Gosu::KbLeftControl)
       @game = Game.new(self)
    end
  end
  def draw
    @game.draw
  end

end

window = Twelve.new
window.show
