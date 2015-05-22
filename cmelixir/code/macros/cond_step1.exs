#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
defmodule ControlFlow do

  # [{:->, [], [[{:>=, [...], [{:temperature, [], Elixir}, 212]}], "boiling"]},
  #  {:->, [], [[{:<=, [...], [{:temperature, [], Elixir}, 32]}], "freezing"]}]
  defmacro cond(do: conditions) do
    clauses = Enum.map conditions, fn {:->, _, [[expr], block]} -> 
      {
        quote(do: fn -> unquote(expr) end),
        quote(do: fn -> unquote(block) end)
      }
    end
  end
end

