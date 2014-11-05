#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
puts "So, how are you liking the pace so far?"

pace = loop do
  puts "(1) Move it along"
  puts "(2) Just right"
  puts "(3) Not so fast!"

  res = gets.to_i
  break res if (1..3).include? res
end

puts (pace == 2) ?
  "Great; see you in the next section" :
  "Thanks; we'll see what we can do"
