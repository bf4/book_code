#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module M
  class C
    X = 'a constant'
  end
  C::X # => "a constant"
end

M::C::X # => "a constant"

Y = 'a root-level constant'

module M
  Y = 'a constant in M'
  Y      # => "a constant in M"
  ::Y    # => "a root-level constant"
end

M.constants                        # => [:C, :Y]
Module.constants.include? :Object  # => true
Module.constants.include? :Module  # => true

module M
  class C
    module M2
      Module.nesting    # => [M::C::M2, M::C, M]
    end
  end
end

require_relative "../test/assertions"

assert_equals [:C, :Y], M.constants
assert Module.constants.include? :Object
assert Module.constants.include? :Module

assert_equals "a constant", M::C::X

module M
  class C
    assert_equals "a constant in M", ::M::Y
    
    module M2
      assert_equals [M::C::M2, M::C, M], Module.nesting
    end
  end
  assert_equals "a constant", C::X
end
# ~> -:38:in `require_relative': cannot infer basepath (LoadError)
# ~> 	from -:38:in `<main>'
