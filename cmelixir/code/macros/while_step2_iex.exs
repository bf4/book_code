#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
iex> c "while.exs"
[Loop]
iex> import Loop

iex> run_loop = fn ->
...>   pid = spawn(fn -> :timer.sleep(4000) end)
...>   while Process.alive?(pid) do
...>     IO.puts "#{inspect :erlang.time} Stayin' alive!"
...>     :timer.sleep 1000
...>   end
...> end
#Function<20.90072148/0 in :erl_eval.expr/5>

iex> run_loop.()
{8, 11, 15} Stayin' alive!
{8, 11, 16} Stayin' alive!
{8, 11, 17} Stayin' alive!
{8, 11, 18} Stayin' alive!
:ok
iex>
