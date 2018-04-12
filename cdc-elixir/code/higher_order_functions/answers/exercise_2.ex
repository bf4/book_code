#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
defmodule Fibonacci do
  def sequence(n) do
    Stream.unfold({0, 1}, fn {n1, n2} -> {n1, {n2, n1 + n2}} end)
    |> Enum.take(n)
  end
end
