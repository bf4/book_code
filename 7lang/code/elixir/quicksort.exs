#---
# Excerpted from "Seven More Languages in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/7lang for more book information.
#---
defmodule QuickSort do
  def sort([]), do: []
  def sort([head|tail]) do
    sort( for(x <- tail, x <= head, do: x) ) ++
    [head] ++
    sort( for(x <- tail, x > head, do: x) )
  end
end

IO.inspect QuickSort.sort([5, 6, 3, 2, 7, 8])

