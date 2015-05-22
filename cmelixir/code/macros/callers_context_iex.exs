#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
iex> c "callers_context.exs"
In macro's context (Elixir.Mod).
In caller's context (Elixir.MyModule).
[MyModule, Mod]

iex> MyModule.friendly_info
My name is Elixir.MyModule
My functions are [friendly_info: 0]

:ok
