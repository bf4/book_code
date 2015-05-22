#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---
class Score

   def initialize(window)
    @font = Gosu::Font.new(window, 'system', 30)
    @value = 0
   end

   def draw
    @font.draw("#{@value}",700,30,2)
   end

   def change_by(number)
    @value += number
   end

end

