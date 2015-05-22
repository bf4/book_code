#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
iex> c "math.exs"
[Math]

iex> require Math
nil

iex> Math.say 5 + 2
5 plus 2 is 7
7

iex> Math.say 18 * 4
18 times 4 is 72
72
