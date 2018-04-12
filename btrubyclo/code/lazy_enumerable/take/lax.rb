#---
# Excerpted from "Mastering Ruby Closures",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/btrubyclo for more book information.
#---
module Enumerable
  def lax
    Lax.new(self)
  end
end

class Lax < Enumerator
  def initialize(receiver)
    super() do |yielder|
      begin
        receiver.each do |val|
          if block_given?
            yield(yielder, val)
          else
            yielder << val
          end
        end
      rescue StopIteration
      end
    end
  end

  def map(&block)
    Lax.new(self) do |yielder, val|
      yielder << block.call(val)
    end
  end

  def take(n)
    taken = 0
    Lax.new(self) do |yielder, val|
      if taken < n
        yielder << val
        taken += 1
      else
        raise StopIteration
      end
    end
  end
end
