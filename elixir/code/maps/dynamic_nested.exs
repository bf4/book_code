#---
# Excerpted from "Programming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/elixir for more book information.
#---
nested = %{
    buttercup: %{ 
      actor: %{
        first: "Robin",
        last:  "Wright"
      },
      role: "princess"
    },
    westley: %{
      actor: %{
        first: "Carey",
        last:  "Ewes"     # typo!
      },
      role: "farm boy"
    }
}

IO.inspect get_in(nested, [:buttercup])
# => %{actor: %{first: "Robin", last: "Wright"}, role: "princess"}

IO.inspect get_in(nested, [:buttercup, :actor])
# => %{first: "Robin", last: "Wright"}

IO.inspect get_in(nested, [:buttercup, :actor, :first])  
# => "Robin"

IO.inspect put_in(nested, [:westley, :actor, :last], "Elwes")
# => %{buttercup: %{actor: %{first: "Robin", last: "Wright"}, role: "princess"},
# =>     westley: %{actor: %{first: "Carey", last: "Elwes"}, role: "farm boy"}}

                    