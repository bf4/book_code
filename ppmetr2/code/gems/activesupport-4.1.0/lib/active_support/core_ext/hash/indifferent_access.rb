#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support/hash_with_indifferent_access'

class Hash

  # Returns an <tt>ActiveSupport::HashWithIndifferentAccess</tt> out of its receiver:
  #
  #   { a: 1 }.with_indifferent_access['a'] # => 1
  def with_indifferent_access
    ActiveSupport::HashWithIndifferentAccess.new_from_hash_copying_default(self)
  end

  # Called when object is nested under an object that receives
  # #with_indifferent_access. This method will be called on the current object
  # by the enclosing object and is aliased to #with_indifferent_access by
  # default. Subclasses of Hash may overwrite this method to return +self+ if
  # converting to an <tt>ActiveSupport::HashWithIndifferentAccess</tt> would not be
  # desirable.
  #
  #   b = { b: 1 }
  #   { a: b }.with_indifferent_access['a'] # calls b.nested_under_indifferent_access
  #   # => {"b"=>32}
  alias nested_under_indifferent_access with_indifferent_access
end
