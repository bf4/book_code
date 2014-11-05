#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Fixnum
  alias_method :old_plus, :+
  
  def +(value)
    self.old_plus(value).old_plus(1)
  end
end

require_relative '../test/assertions'
assert_equals 3, 1 + 1
assert_equals 1, -1 + 1
assert_equals 111, 100 + 10
