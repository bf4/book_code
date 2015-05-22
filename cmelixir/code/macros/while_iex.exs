#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
iex> c "while.exs"
[Loop]

iex> import Loop
nil

iex>
pid = spawn fn ->
  while true do
    receive do
      :stop ->
        IO.puts "Stopping..."
        break
      message ->
        IO.puts "Got #{inspect message}"
    end
  end
end
#PID<0.93.0>

iex> send pid, :hello
Got :hello
:hello

iex> send pid, :ping
Got :ping
:ping

iex> send pid, :stop
Stopping...
:stop

iex> Process.alive? pid
false
