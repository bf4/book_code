#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
class Array
  # Calls the attached block of code once for each permutation.
  def each_permutation(&block)
    # We'll need to permute the array L! times.
    factorial = (1..length).inject(1) { |p, n| p * n }

    # Make a copy, so we don't modify the original array.
    copy = clone
    block.call copy

    (factorial - 1).times do
      copy.permute!
      block.call copy
    end
  end
end

class Array
  # Generate one permutation by Dijkstra's algorithm.
  def permute!
    i = length - 1

    i -= 1 while at(i - 1) >= at(i)
    j = length
    j -= 1 while at(j - 1) <= at(i - 1)

    swap(i - 1, j - 1)

    i += 1
    j = length

    while i < j
      swap(i - 1, j - 1)
      i += 1
      j -= 1
    end
  end

  def swap(a, b)
    self[a], self[b] = [self[b], self[a]]
  end
end


require 'benchmark'

def do_something_with(data)
  # Your favorite operation here
end

5.times do
  timing = Benchmark.measure do
    letters = ['f', 'a', 'c', 'e', 't', 's']
    letters.each_permutation do |p|
      do_something_with(p)
    end
  end

  puts timing
end
