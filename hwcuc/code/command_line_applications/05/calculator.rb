#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
input = File.read(ARGV[0])
numbers_to_add = input.split('+').map { |n| n.to_i }

total = 0
numbers_to_add.each do |number|
  total += number
end

print(total)