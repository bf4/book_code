#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
# defmodule NumberCompareTest do
#   use ExUnit.Case
#
#   describe "#greater" do
#     import NumberCompare
#
#     test "shows the greater" do
#       assert greater(4, 2) == 4
#       assert greater(2, 4) == 4
#       assert greater(4, 4) == 4
#     end
#   end
#
#   describe "GuardClauses#greater" do
#     import GuardClauses.NumberCompare
#
#     test "shows the greater" do
#       assert greater(4, 2) == 4
#       assert greater(2, 4) == 4
#       assert greater(4, 4) == 4
#     end
#   end
# end
