#---
# Excerpted from "Arduino: A Quick-Start Guide, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msard2 for more book information.
#---
require 'RMagick'
include Magick

image = Image::read(ARGV[0]).first 

puts '#include "thermometer.h"'
puts 'PROGMEM const unsigned char thermometer[] = {'
puts "  #{image.columns}, #{image.rows}," 

(0..image.rows).each do |y|
  print '  B'
  (0..image.columns).each do |x|
    pixel = image.pixel_color(x, y) 
    print pixel.red == 0 ? '0' : '1'
    print ', B' if (x + 1) % 8 == 0
  end
  print '0' * ((image.columns - 1) % 8)
  puts ','
end

puts '};'
