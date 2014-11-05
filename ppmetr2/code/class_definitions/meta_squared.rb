#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class << "abc"
  class << self
    self  # => #<Class:#<Class:#<String:0x33552c>>>
  end
end

require_relative '../test/assertions'
singleton_class_of_singleton_class = class << "abc"; class << self; self; end; end
assert_matches "#\<Class:#\<Class:#\<String:0x\\w+\>\>\>", singleton_class_of_singleton_class
