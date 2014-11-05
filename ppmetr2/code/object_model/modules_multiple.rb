#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module M1; end

module M2
  include M1
end

module M3
  prepend M1
  include M2
end

M3.ancestors # => [M1, M3, M2]

require_relative '../test/assertions'
assert_equals [M1, M3, M2], M3.ancestors
