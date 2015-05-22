#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
iex> c "macros/if_step1.exs"
[ControlFlow]

iex> require ControlFlow
nil

iex>
ControlFlow.if expression1 do
  "block1"
elsif expression2
  "block2"
elsif expression3
  "block3"
else
  "else block"
end

if_expr:    {:expression1, [line: 20], nil}
if_block:   "block1"
elsifs:     [
              {:elsif, [line: 22], [{:expression2, [line: 22], nil}]},
              "block2",
              {:elsif, [line: 24], [{:expression3, [line: 24], nil}]},
              "block3"
            ]
else_block: "else block"
:ok

iex>
