#---
# Excerpted from "Programming Elixir ≥ 1.6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir16 for more book information.
#---
defmodule StatsPropertyTest do
  use ExUnit.Case
  use ExUnitProperties
  
  describe "Stats on lists of ints" do

    @tag :two
    property "count not negative" do
      check all l <- list_of(integer()) do
        assert Stats.count(l) >= 0
      end
    end

    @tag :two
    property "single element lists are their own sum" do
      check all number <- integer() do
        assert Stats.sum([number]) == number
      end
    end

    @tag :two
    property "sum equals average times count" do
      check all l <- list_of(integer()) do
        assert_in_delta(
          Stats.sum(l),
          Stats.count(l)*Stats.average(l),
          1.0e-6
        )
      end
    end

    property "sum equals average times count (nonempty)" do
      check all l <- list_of(integer()) |> nonempty do
        assert_in_delta(
          Stats.sum(l),
          Stats.count(l)*Stats.average(l),
          1.0e-6
        )
      end
    end

    property "sum equals average times count (min_length)" do
      check all l <- list_of(integer(), min_length: 1) do
        assert_in_delta(
          Stats.sum(l),
          Stats.count(l)*Stats.average(l),
          1.0e-6
        )
      end
    end
    

   end
end
