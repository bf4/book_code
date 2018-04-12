#---
# Excerpted from "Programming Elixir ≥ 1.6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir16 for more book information.
#---
defmodule Duper.WorkerSupervisor do
  use Supervisor

  @me WorkerSupervisor
  
  def start_link(_) do
    Supervisor.start_link(__MODULE__, :no_args, name: @me)
  end


  def init(:no_args) do
    Supervisor.init(
      [ Duper.Worker ],
      strategy: :simple_one_for_one
    )
  end

  def add_worker() do
    {:ok, _pid} = Supervisor.start_child(@me, [])
  end
end
