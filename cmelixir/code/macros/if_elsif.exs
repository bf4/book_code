#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
defmodule ControlFlow do

  defmacro if(if_expr, do: {_, _, [if_block | elsifs]}, else: else_block) do
    elsif_clauses = elsifs |> Enum.chunk(2) |> Enum.flat_map fn
      [{:elsif, _, [expr]}, block] -> clause(expr, block)
    end

    quote do
      cond do: unquote(
        clause(if_expr, if_block) ++
        elsif_clauses ++
        clause(true, else_block)
      )
    end
  end

  defp clause(expression, block) do
    quote do: (unquote(expression) -> unquote(block))
  end
end

