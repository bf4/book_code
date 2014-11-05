#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Hash
  # Returns a new hash with +self+ and +other_hash+ merged recursively.
  #
  #   h1 = { x: { y: [4, 5, 6] }, z: [7, 8, 9] }
  #   h2 = { x: { y: [7, 8, 9] }, z: 'xyz' }
  #
  #   h1.deep_merge(h2) # => {x: {y: [7, 8, 9]}, z: "xyz"}
  #   h2.deep_merge(h1) # => {x: {y: [4, 5, 6]}, z: [7, 8, 9]}
  #   h1.deep_merge(h2) { |key, old, new| Array.wrap(old) + Array.wrap(new) }
  #   # => {:x=>{:y=>[4, 5, 6, 7, 8, 9]}, :z=>[7, 8, 9, "xyz"]}
  def deep_merge(other_hash, &block)
    dup.deep_merge!(other_hash, &block)
  end

  # Same as +deep_merge+, but modifies +self+.
  def deep_merge!(other_hash, &block)
    other_hash.each_pair do |k,v|
      tv = self[k]
      if tv.is_a?(Hash) && v.is_a?(Hash)
        self[k] = tv.deep_merge(v, &block)
      else
        self[k] = block && tv ? block.call(k, tv, v) : v
      end
    end
    self
  end
end
