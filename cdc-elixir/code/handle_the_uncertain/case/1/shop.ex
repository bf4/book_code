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
    case ask_number("Quantity?") do
      :error ->
        IO.puts("It's not a number")
      {quantity, _} ->
        case ask_number("Price?") do
          :error ->
            IO.puts("It's not a number")
          {price, _} ->
            quantity * price
        end
    end
  end

  def ask_number(message) do
    message <> "\n"
      |> IO.gets
      |> Integer.parse
  end
end
