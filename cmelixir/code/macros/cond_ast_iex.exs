#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
iex(1)> quote do
...(1)>   temperature >= 212 -> "boiling"
...(1)>   temperature <= 32  -> "freezing"
...(1)> end
[{:->, [],
  [[{:>=, [context: Elixir, import: Kernel],
     [{:temperature, [], Elixir}, 212]}], "boiling"]},
 {:->, [],
  [[{:<=, [context: Elixir, import: Kernel], [{:temperature, [], Elixir}, 32]}],
   "freezing"]}]

