#---
# Excerpted from "Programming Elixir ≥ 1.6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir16 for more book information.
#---
defmodule Duper.ResultsTest do
  use ExUnit.Case
  alias Duper.Results
  
  test "can add entries to the results" do

    Results.add_hash_for("path1", 123)
    Results.add_hash_for("path2", 456)
    Results.add_hash_for("path3", 123)
    Results.add_hash_for("path4", 789)
    Results.add_hash_for("path5", 456)
    Results.add_hash_for("path6", 999)
    
    duplicates = Results.find_duplicates()

    assert length(duplicates) == 2

    assert ~w{path3 path1} in duplicates
    assert ~w{path5 path2} in duplicates
  end
  
end
