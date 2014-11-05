#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class String
  # The inverse of <tt>String#include?</tt>. Returns true if the string
  # does not include the other string.
  #
  #   "hello".exclude? "lo" # => false
  #   "hello".exclude? "ol" # => true
  #   "hello".exclude? ?h   # => false
  def exclude?(string)
    !include?(string)
  end
end
