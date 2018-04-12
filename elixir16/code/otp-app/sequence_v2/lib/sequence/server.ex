#---
# Excerpted from "Programming Elixir ≥ 1.6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir16 for more book information.
#---
defmodule Sequence.Server do
  use     GenServer
  require Logger

  @vsn "1"
  
  defmodule State do
    defstruct(current_number: 0, delta: 1)
  end
  
  #####
  # External API  

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def next_number do
    with number = GenServer.call(__MODULE__, :next_number),
    do:  "The next number is #{number}"
  end

  def increment_number(delta) do
    GenServer.cast __MODULE__, {:increment_number, delta}
  end

  #####
  # GenServer implementation

  def init(_) do
    state = %State{ current_number: Sequence.Stash.get() }
    { :ok, state }
  end
  
  def handle_call(:next_number, _from, state = %{current_number: n}) do
    { :reply, n, %{state | current_number: n + state.delta} }
  end

  def handle_cast({:increment_number, delta}, state) do
    { :noreply, %{state | delta: delta }}
  end

  def terminate(_reason, current_number) do
    Sequence.Stash.update(current_number)
  end

  def code_change("0", old_state = current_number, _extra) do
    new_state = %State{
      current_number: current_number,
      delta:          1
    }
    Logger.info "Changing code from 0 to 1"
    Logger.info inspect(old_state)
    Logger.info inspect(new_state)
    { :ok, new_state }
  end

end
