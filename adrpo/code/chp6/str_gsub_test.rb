#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
str = "x"*1024*1024*10

def test(str)
  str.gsub!("x", "y")
end

measurement1 = `ps -o rss= -p #{Process.pid}`.to_i/1024
test(str)
GC.start
measurement2 = `ps -o rss= -p #{Process.pid}`.to_i/1024

puts "memory added by string replacement: #{measurement2 - measurement1}"
