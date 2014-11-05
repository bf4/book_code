#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class C
  def initialize
    @x = 1
  end
end

class D
  def twisted_method
    @y = 2
    C.new.instance_eval { "@x: #{@x}, @y: #{@y}" }
  end
end

D.new.twisted_method  # => "@x: 1, @y: "

require_relative '../test/assertions'
assert_equals "@x: 1, @y: ", D.new.twisted_method

class D
  def twisted_method
    @y = 2
    C.new.instance_exec(@y) {|y| "@x: #{@x}, @y: #{y}" }
  end
end

D.new.twisted_method  # => "@x: 1, @y: 2"

assert_equals "@x: 1, @y: 2", D.new.twisted_method
