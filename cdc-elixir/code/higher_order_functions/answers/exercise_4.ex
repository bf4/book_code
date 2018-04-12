#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
defmodule Quicksort do
  def sort([]), do: []
  def sort([pivot | tail]) do
    {lesser, greater} = Enum.split_with(tail, &(&1 <= pivot))
    sort(lesser) ++ [pivot] ++ sort(greater)
  end
end
