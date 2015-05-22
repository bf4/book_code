#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
iex> number = 5
5

iex> ast = quote do
...>   number * 10
...> end
{:*, [context: Elixir, import: Kernel], [{:number, [], Elixir}, 10]}  

iex> Code.eval_quoted ast
** (CompileError) nofile:1: undefined function number/0

iex> ast = quote do
...>   unquote(number) * 10 
...> end
{:*, [context: Elixir, import: Kernel], [5, 10]}

iex> Code.eval_quoted ast
{50, []}
