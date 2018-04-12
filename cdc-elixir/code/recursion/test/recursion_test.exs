#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
defmodule RecursionTest do
  use ExUnit.Case
  doctest Recursion

  describe "Count.to" do
    test "from 0 to given number" do
      assert Counter.countdown(10) == "10 9 8 7 6 5 4 3 2 1 0"
    end
  end

  describe "Math.sum" do
    test "sum numbers in a list" do
      assert Math.sum([10, 5, 15]) == 30
    end
  end

  describe "EnchanterShop.prepare_for_sale" do
    test "transform in magic items" do
      items = [
        %{title: "Longsword", price: 50, magic: false},
        %{title: "Rope", price: 10, magic: false},
      ]

      assert EnchanterShop.enchant_for_sale(items) == [
        %{title: "Edwin's Longsword", price: 150, magic: true},
        %{title: "Edwin's Rope", price: 30, magic: true}
      ]
    end

    test "does not transform magic items" do
      items = EnchanterShop.test_data

      assert EnchanterShop.enchant_for_sale(items) == [
        %{title: "Edwin's Longsword", price: 150, magic: true},
        %{title: "Healing Potion", price: 60, magic: true},
        %{title: "Edwin's Rope", price: 30, magic: true},
        %{title: "Dragon's Spear", price: 100, magic: true}
      ]
    end
  end

  # "0 1 2 3 4 5 6 7 8 9 10"
end
