#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
File.open("data/wksst8110.for") do |file|
  puts file.read(10)
  4.times do
    puts file.read(9)
    puts file.read(4)
  end
end
# >>  03JAN1990
# >>      23.4
# >> -0.4
# >>      25.1
# >> -0.3
# >>      26.6
# >>  0.0
# >>      28.6
# >>  0.3
