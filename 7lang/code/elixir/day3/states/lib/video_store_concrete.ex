#---
# Excerpted from "Seven More Languages in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/7lang for more book information.
#---
defmodule VideoStore.Concrete do import StateMachine.Behavior
  def rent(video), do: fire(state_machine, video, :rent)
  def return(video), do: fire(state_machine, video, :return)
  def lose(video), do: fire(state_machine, video, :lose)
  def state_machine do
    [ available: [
        rent:   [ to: :rented,    calls: [&VideoStore.renting/1]   ]],
      rented: [
        return: [ to: :available, calls: [&VideoStore.returning/1] ],
        lose:   [ to: :lost,      calls: [&VideoStore.losing/1]    ]],
      lost: [] ]
  end
end
