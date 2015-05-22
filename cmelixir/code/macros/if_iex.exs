#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
iex> quote do
  if first_expr do
    "block1"
  elsif second_expr
    "block2"
  elsif third_expr
    "block3"
  else
    "else block"
  end
end

{:if, [context: Elixir, import: Kernel],
 [{:first_expr, [], Elixir},                    # (1)
  [do: {:__block__, [],[
    "block1",                                   # (2)
    {:elsif, [], [{:second_expr, [], Elixir}]}, # (3)
    "block2",
    {:elsif, [], [{:third_expr, [], Elixir}]},
    "block3"
   ]},
   else: "else block"]]}                        # (4)

iex> quote do
 :expression -> :block
end
[{:->, [], [[:expression], :block]}]

