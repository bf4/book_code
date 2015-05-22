#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
# Final
defmodule ControlFlow do

  defmacro if(if_expr, do: {_, _, [if_block | elsifs]}, else: else_block) do
    clauses = elsifs
    |> Enum.chunk(2)
    |> Enum.map(fn [{:elsif, _, [expr]}, block] -> clause(expr, block) end)
    |> List.insert_at(0, clause(if_expr, if_block))
    |> Kernel.++([clause(true, else_block)])

    quote do
      cond do: unquote(clauses) 
    end
  end

  defp clause(left, right) do
    (quote do: (unquote(left) -> unquote(right))) |> Enum.at(0)
  end
end

# Step 2
defmodule ControlFlow do

  defmacro if(if_expr, do: {_, _, [if_block | elsifs]}, else: else_block) do
    clauses = elsifs
    |> Enum.chunk(2)
    |> Enum.map(fn [{:elsif, _, [expr]}, block] -> clause(expr, block) end)

    IO.puts Macro.to_string(clauses)
  end

  defp clause(expression, block) do
    (quote do: (unquote(expression) -> unquote(block))) |> Enum.at(0)
  end
end

# Step 3

defmodule ControlFlow do

  defmacro if(if_expr, do: {_, _, [if_block | elsifs]}, else: else_block) do
    clauses = elsifs
    |> Enum.chunk(2)
    |> Enum.map(fn [{:elsif, _, [expr]}, block] -> clause(expr, block) end) 
    |> List.insert_at(0, clause(if_expr, if_block))                         
    |> Kernel.++([clause(true, else_block)])                                

    IO.puts Macro.to_string(clauses)
  end

  defp clause(expression, block) do
    (quote do: (unquote(expression) -> unquote(block))) |> Enum.at(0)
  end
end


