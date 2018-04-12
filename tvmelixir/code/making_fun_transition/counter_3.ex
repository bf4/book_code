#---
# Excerpted from "Adopting Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/tvmelixir for more book information.
#---
defmodule Counter do
  def read(counter, timeout \\ 5000) do
    ref = Process.monitor(counter)
    send counter, {:read, {self(), ref}}
    receive do
      {^ref, counter} ->
        Process.demonitor(ref, [:flush])
        {:ok, counter}
      {:DOWN, ^ref, _, _, reason} ->
        exit(reason)
    after
      timeout -> exit(:timeout)
    end
  end

  def bump(counter) do
    send counter, :bump
  end

  def start_link(initial_value) do
    {:ok, spawn_link(__MODULE__, :loop, [initial_value])}
  end

  def loop(counter) do
    receive do
      {:read, {caller, ref}} ->
        send(caller, {ref, counter})
        loop(counter)
      :bump ->
        loop(counter + 1)
    end
  end
end
