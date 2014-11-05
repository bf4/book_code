#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
1.upto(100).with_object('') do |i, x|
  if i % 3 == 0
    x += 'Fizz' 
  end
  if i % 5 == 0
    x += 'Buzz' 
  end
  if x.empty?
    puts i
  else
    puts x
  end
end
