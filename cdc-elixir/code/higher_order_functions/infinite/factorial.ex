#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
defmodule Factorial do
  def of(0), do: 1
  def of(n) when n > 0 do
    Stream.iterate(1, &(&1 + 1))
      |> Enum.take(n)
      |> Enum.reduce(&(&1* &2))
  end
end
