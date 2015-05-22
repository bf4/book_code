#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
iex> quote do: 5 + 2
{:+, [context: Elixir, import: Kernel], [5, 2]}

iex)> quote do: 1 * 2 + 3
{:+, [context: Elixir, import: Kernel],
 [{:*, [context: Elixir, import: Kernel], [1, 2]}, 3]}
