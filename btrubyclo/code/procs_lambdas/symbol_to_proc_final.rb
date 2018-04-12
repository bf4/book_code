#---
# Excerpted from "Mastering Ruby Closures",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/btrubyclo for more book information.
#---
class Symbol
  def to_proc
    proc { |obj, args| obj.send(self, *args) }
  end
end

words = %w(underwear should be worn on the inside)
words.map &:length # => [9, 6, 2, 4, 2, 3, 6]

[1, 2, 3].inject(&:+) # => 6
