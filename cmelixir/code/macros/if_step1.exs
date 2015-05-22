#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
defmodule ControlFlow do

  # [{:first_expr, [], Elixir},
  #  [do: {:__block__, [],[
  #    "block1",
  #    {:elsif, [], [{:second_expr, [], Elixir}]},
  #    "block2",
  #   ]},
  #   else: "else block"]]}
  defmacro if(if_expr, do: {_, _, [if_block | elsifs]}, else: else_block) do
    IO.puts "if_expr:    #{inspect if_expr}"
    IO.puts "if_block:   #{inspect if_block}"
    IO.puts "elsifs:     #{inspect elsifs}"
    IO.puts "else_block: #{inspect else_block}"
  end
end

