#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Hash
  # Merges the caller into +other_hash+. For example,
  #
  #   options = options.reverse_merge(size: 25, velocity: 10)
  #
  # is equivalent to
  #
  #   options = { size: 25, velocity: 10 }.merge(options)
  #
  # This is particularly useful for initializing an options hash
  # with default values.
  def reverse_merge(other_hash)
    other_hash.merge(self)
  end

  # Destructive +reverse_merge+.
  def reverse_merge!(other_hash)
    # right wins if there is no left
    merge!( other_hash ){|key,left,right| left }
  end
  alias_method :reverse_update, :reverse_merge!
end
