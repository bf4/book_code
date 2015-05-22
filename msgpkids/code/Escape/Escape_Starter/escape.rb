#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---
require 'gosu'
require 'chipmunk'

class Escape < Gosu::Window
	
	def initialize
		super 800,800,false
    self.caption = "Escape"
  end

  def draw
    
  end

  def update
    
  end

end

window = Escape.new
window.show
