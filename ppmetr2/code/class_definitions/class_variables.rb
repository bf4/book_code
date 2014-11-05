#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class C
  @@v = 1  
end

class D < C
  def my_method; @@v; end
end

D.new.my_method  # => 1

require_relative '../test/assertions'
assert_equals 1, D.new.my_method

@@v = 1

class MyClass
  @@v = 2
end

@@v  # => 2

require_relative '../test/assertions'
assert_equals 2, @@v
