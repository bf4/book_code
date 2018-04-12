#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
#
defmodule Factorial do
  def of(0), do: 1
  def of(1), do: 1
  def of(2), do: 2 * 1
  def of(3), do: 3 * 2 * 1
  def of(4), do: 4 * 3 * 2 * 1
end
#

#
defmodule Factorial do
  def of(0), do: 1
  def of(1), do: 1 * of(0)
  def of(2), do: 2 * of(1)
  def of(3), do: 3 * of(2)
  def of(4), do: 4 * of(3)
end
#

#
defmodule Factorial do
  def of(0), do: 1
  #
  def of(n) when n > 0, do: n * of(n - 1)
  #
end
#
