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
    quantity = ask_number("Quantity?")
    price = ask_number("Price?")
    calculate(quantity, price)
  end

  def calculate(:error, _), do: IO.puts("Quantity is not a number")
  def calculate(_, :error), do: IO.puts("Price is not a number")
  def calculate({quantity, _}, {price, _}), do: quantity * price

  def ask_number(message) do
    message <> "\n"
      |> IO.gets
      |> Integer.parse
  end
end
