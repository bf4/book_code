#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
defmodule WordBuilder do
  def build(alphabet, positions) do
    letters = Enum.map(positions, String.at(alphabet))
    Enum.join(letters)
  end

  def build(alphabet, positions) do
    partial = fn at -> String.at(alphabet, at) end
    letters = Enum.map(positions, partial)
    Enum.join(letters)
  end

  def build(alphabet, positions) do
    letters = Enum.map(positions, &(String.at(alphabet, &1)))
    Enum.join(letters)
  end
end
