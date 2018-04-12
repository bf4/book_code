#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
defmodule Shop do
  def checkout() do
    try do
      {quantity, _} = ask_number("Quantity?")
      {price, _} = ask_number("Price?")
      quantity * price
    rescue
      MatchError -> "It's not a number"
    end
  end

  def ask_number(message) do
    message <> "\n"
      |> IO.gets
      |> Integer.parse
  end
end
