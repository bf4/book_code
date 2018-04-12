#---
# Excerpted from "Adopting Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/tvmelixir for more book information.
#---
defmodule BeliefStructure.Hexify do
  def name(package) do
    package(package)
  end

  defp package(package) do
    package <> "_ex"
  end
end
