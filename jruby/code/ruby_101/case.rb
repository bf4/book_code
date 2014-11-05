#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
def tell_me_about(value)
  case value
  when 0..9
    puts "It's a one-digit number"
  when Fixnum
    puts "It's an integer"
  when /[A-Z]{2}/
    puts "It's two capital letters"
  when String
    puts "It's a string"
  else
    puts "Don't know what it is"
  end
end
