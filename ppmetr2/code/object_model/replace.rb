#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'test/unit'

def replace(array, original, replacement)
  array.map {|e| e == original ? replacement : e }
end

class ReplacementTest < Test::Unit::TestCase
def test_replace
  original = ['one', 'two', 'one', 'three']
  replaced = replace(original, 'one', 'zero') 
  assert_equal ['zero', 'two', 'zero', 'three'], replaced
end
end

class Array
  def replace(original, replacement)
    self.map {|e| e == original ? replacement : e }
  end
end

require 'test/unit'

class ArrayExtensionTest < Test::Unit::TestCase
def test_replace
  original = ['one', 'two', 'one', 'three']
  replaced = original.replace('one', 'zero') 
  assert_equal ['zero', 'two', 'zero', 'three'], replaced
end
end
