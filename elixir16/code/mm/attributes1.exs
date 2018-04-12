#---
# Excerpted from "Programming Elixir ≥ 1.6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir16 for more book information.
#---
defmodule Example do
  @attr "one"
  def first, do: @attr
  @attr "two"
  def second, do: @attr
end
IO.puts "#{Example.second}  #{Example.first}"    # => two  one
