#---
# Excerpted from "Programming Elixir ≥ 1.6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir16 for more book information.
#---
defmodule DefaultParams1 do

  def func(p1, p2 \\ 123) do
    IO.inspect [p1, p2]
  end

  def func(p1, 99) do
    IO.puts "you said 99"
  end

end