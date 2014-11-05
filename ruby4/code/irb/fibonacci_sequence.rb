#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
def fibonacci_sequence
  Enumerator.new do |generator|
    i1, i2 = 1, 1
    loop do   
      generator.yield i1
      i1, i2 = i2, i1+i2
    end
  end
end
