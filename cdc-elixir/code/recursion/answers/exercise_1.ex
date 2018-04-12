#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
defmodule MyList do
  def max([]), do: nil
  def max([a]), do: a
  def max([a, b | rest]) when a >= b, do: find_max(rest, a)
  def max([a, b | rest]) when a < b, do: find_max(rest, b)

  defp find_max([], max), do: max
  defp find_max([head | rest], max) when head >= max, do: find_max(rest, head)
  defp find_max([head | rest], max) when head < max, do: find_max(rest, max)

  def min([]), do: nil
  def min([a]), do: a
  def min([a, b | rest]) when a <= b, do: find_min(rest, a)
  def min([a, b | rest]) when a > b, do: find_min(rest, b)

  defp find_min([], min), do: min
  defp find_min([head | rest], min) when head <= min, do: find_min(rest, head)
  defp find_min([head | rest], min) when head > min, do: find_min(rest, min)
end
