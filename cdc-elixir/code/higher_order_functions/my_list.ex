#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
defmodule MyList do
  #
  def each([], _function), do: nil
  def each([head | tail], function) do
    function.(head)
    each(tail, function)
  end
  #

  #
  def map([], _function), do: []
  def map([head | tail], function) do
    [function.(head) | map(tail, function)]
  end
  #

  #
  def reduce([], acc, _function), do: acc
  def reduce([head | tail], acc, function) do
    reduce(tail, function.(head, acc), function)
  end
  #

  #
  def filter([], _function), do: []
  def filter([head | tail], function) do
    if function.(head) do
      [head | filter(tail, function)]
    else
      filter(tail, function)
    end
  end
  #
end
