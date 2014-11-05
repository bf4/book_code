#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
begin
  puts "Everything's fine so far"
  raise "I'm raising an exception right now"
  puts "Ruby will never run this line"
rescue => e
  puts "My exception says: #{e}"
end

class ImCold < RuntimeError
end

begin
  raise ImCold, "Brrr, it's chilly in here!"
rescue ImCold => e
  puts "I'm cold. #{e}"
rescue Exception => e
  puts "Some exception other than ImCold was thrown."
ensure
  puts "This will _always_ print, kinda like Java's finally"
end
