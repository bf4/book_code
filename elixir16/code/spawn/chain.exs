#---
# Excerpted from "Programming Elixir ≥ 1.6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir16 for more book information.
#---
defmodule Chain do
  def counter(next_pid) do    
    receive do
      n -> 
        send next_pid, n + 1
    end
  end

  def create_processes(n) do
    code_to_run = fn (_,send_to) -> 
      spawn(Chain, :counter, [send_to]) 
    end 
    
    last = Enum.reduce(1..n, self(), code_to_run) 
             
    send(last, 0)    # start the count by sending a zero to the last process

    receive do       # and wait for the result to come back to us
      final_answer when is_integer(final_answer) -> 
        "Result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    :timer.tc(Chain, :create_processes, [n])
    |> IO.inspect
  end
end

