#---
# Excerpted from "Mastering Ruby Closures",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/btrubyclo for more book information.
#---
class Array
  def each
    x = 0
    while x < self.length
      yield self[x]
      x += 1
    end
  end
end

%w(look ma no for loops).each do |x|
  puts x
end
