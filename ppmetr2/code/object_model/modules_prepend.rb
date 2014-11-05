#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module M2
  def my_method
    'M2#my_method()'
  end
end

class C2
  prepend M2
end

class D2 < C2; end

D2.ancestors # => [D2, M2, C2, Object, Kernel, BasicObject]

require_relative '../test/assertions'
assert_equals [D2, M2, C2, Object, Kernel, BasicObject], D2.ancestors
