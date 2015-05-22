#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
iex> defmodule Setter do
...>   defmacro bind_name(string) do
...>     quote do
...>       name = unquote(string)
...>     end
...>   end
...> end
{:module, Setter, ...
