#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
# defmodule Checkout do
#   use ExUnit.Case
#
#   describe "#total_cost" do
#     import Checkout
#
#     test "applies the taxes" do
#       assert total_cost(4, 1) == 8
#     end
#
#     test "only positive numbers" do
#       assert_raise MatchError, total_cost(-1, 4)
#       assert_raise MatchError, total_cost(4, -1)
#     end
#   end
# end
