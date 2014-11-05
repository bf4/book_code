#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
class NondeterminismExample
  attr_reader :position
  
  def initialize(die)
    @die = die
    @position = 0
  end
  
  def move
    @position += @die.roll
  end
  
end