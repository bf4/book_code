#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module M
  def self.append_features(base); end
end

class C
  include M
end

C.ancestors   # => [C, Object, Kernel, BasicObject]

require_relative '../test/assertions'
assert_equals [C, Object, Kernel, BasicObject], C.ancestors
