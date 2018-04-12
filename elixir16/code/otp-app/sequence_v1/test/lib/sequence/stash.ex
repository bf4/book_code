#---
# Excerpted from "Programming Elixir ≥ 1.6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir16 for more book information.
#---
defmodule Sequence.Stash do
  use GenServer

  @me __MODULE__
  
  def start_link(initial_number) do
    GenServer.start_link(__MODULE__, initial_number, name: @me)
  end

  def get() do
    GenServer.call(@me, { :get })
  end
  
  def update(new_number) do
    GenServer.cast(@me, { :update, new_number })
  end

  # Server implementation
  
  def init(initial_number) do
    { :ok, initial_number }
  end

  def handle_call({ :get }, _from, current_number ) do
    { :reply, current_number, current_number }
  end

  def handle_cast({ :update, new_number }, _current_number) do
    { :noreply, new_number }
  end
  
end
