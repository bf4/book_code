#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
defmodule GeneralStore do
  def test_data do
    [
      %{title: "Longsword", price: 50, magic: false},
      %{title: "Healing Potion", price: 60, magic: true},
      %{title: "Rope", price: 10, magic: false},
      %{title: "Dragon's Spear", price: 100, magic: true},
    ]
  end

  def filter_items([], magic: magic), do: []
  def filter_items([item = %{magic: item_magic} | rest], magic: filter_magic)
      when item_magic == filter_magic do
    [item | filter_items(rest, magic: filter_magic)]
  end
  def filter_items([item | rest], magic: filter_magic) do
    filter_items(rest, magic: filter_magic)
  end
end
