#---
# Excerpted from "Seven More Languages in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/7lang for more book information.
#---
defmodule StateMachine do
  defmacro __using__(_) do # (1)
    quote do
      import StateMachine
      @states []
      @before_compile StateMachine
    end
  end

  defmacro state(name, events) do # (2)
    quote do
      @states [{unquote(name), unquote(events)} | @states]
    end
  end

  defmacro __before_compile__(env) do # (3)
    states = Module.get_attribute(env.module, :states)
    events = states
             |> Keyword.values
             |> List.flatten
             |> Keyword.keys
             |> Enum.uniq

    quote do
      def state_machine do # (4)
        unquote(states)
      end

      unquote event_callbacks(events) # (5)
    end
  end

  def event_callback(name) do # (6)
    callback = name
    quote do
      def unquote(name)(context) do
        StateMachine.Behavior.fire(state_machine, context, unquote(callback))
      end
    end
  end

  def event_callbacks(names) do
    Enum.map names, &event_callback/1
  end

end
