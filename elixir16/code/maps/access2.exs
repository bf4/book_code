#---
# Excerpted from "Programming Elixir ≥ 1.6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir16 for more book information.
#---
cast = [
  %{
    character: "Buttercup",
    actor:    {"Robin", "Wright"},
    role:      "princess"
  },
  %{
    character: "Westley",
    actor:    {"Carey", "Elwes"},
    role:      "farm boy"
  }
]

IO.inspect get_in(cast, [Access.all(), :actor, Access.elem(1)])
#=> ["Wright", "Elwes"]

IO.inspect get_and_update_in(cast, [Access.all(), :actor, Access.elem(1)],
                             fn (val) -> {val, String.reverse(val)} end)
#=> {["Wright", "Elwes"],
#    [%{actor: {"Robin", "thgirW"}, character: "Buttercup", role: "princess"},
#     %{actor: {"Carey", "sewlE"}, character: "Westley", role: "farm boy"}]}


                    
