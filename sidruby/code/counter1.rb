#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
class Counter
 def initialize
   @mutex = Mutex.new
   @value = 0
 end
 attr_reader :value

 def up
   @mutex.synchronize do
     @value = @value + 1
   end
 end
end
