#---
# Excerpted from "Seven More Languages in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/7lang for more book information.
#---
defmodule StateMachine.Behavior do
  def fire(context, event) do
    %{context | state: event[:to]}
    |> activate(event)
  end

  def fire(states, context, event_name) do
      event = states[context.state][event_name]
      fire(context, event)
  end

  def activate(context, event) do
    Enum.reduce(event[:calls] || [], context, &(&1.(&2)))
  end
end
