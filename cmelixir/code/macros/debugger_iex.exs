#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
iex> c "debugger.exs"
[Debugger]

iex> require Debugger
nil

iex> Application.put_env(:debugger, :log_level, :debug)
:ok

iex> remote_api_call = fn -> IO.puts("calling remote API...") end
#Function<20.90072148/0 in :erl_eval.expr/5>

iex> Debugger.log(remote_api_call.())
=================
calling remote API...
:ok
=================
calling remote API...
:ok
iex>
