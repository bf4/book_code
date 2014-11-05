#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Hash
  # Returns a hash with non +nil+ values.
  # 
  #   hash = { a: true, b: false, c: nil}
  #   hash.compact # => { a: true, b: false}
  #   hash # => { a: true, b: false, c: nil}
  #   { c: nil }.compact # => {}
  def compact
    self.select { |_, value| !value.nil? }
  end
  
  # Replaces current hash with non +nil+ values.
  # 
  #   hash = { a: true, b: false, c: nil}
  #   hash.compact! # => { a: true, b: false}
  #   hash # => { a: true, b: false}
  def compact!
    self.reject! { |_, value| value.nil? }
  end
end
