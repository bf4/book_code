#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---
require 'gosu'
require_relative 'player'
class SectorFive < Gosu::Window
  def initialize
    super 800,600,false
    self.caption = "Sector Five"
    @player = Player.new(self)
  end
  def update
    if button_down?(Gosu::KbLeft)
      @player.turn_left
    end
    if button_down?(Gosu::KbRight)
      @player.turn_right
    end
    if button_down?(Gosu::KbUp)
      @player.accelerate
    end
    @player.move
  end
  def draw
    @player.draw
  end
end

window = SectorFive.new
window.show
