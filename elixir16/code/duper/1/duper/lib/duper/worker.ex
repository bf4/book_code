#---
# Excerpted from "Programming Elixir ≥ 1.6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir16 for more book information.
#---
defmodule Duper.Worker do
  use GenServer, restart: :transient

  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_args)
  end


  def init(:no_args) do
    Process.send_after(self(), :do_one_file, 0)  
    { :ok, nil }
  end

  def handle_info(:do_one_file, _) do
    Duper.PathFinder.next_path()
    |> add_result()
  end

  defp add_result(nil) do
    Duper.Gatherer.done()
    { :noreply, nil }
  end

  defp add_result(path) do
    Duper.Gatherer.result(path, hash_of_file_at(path))
    send(self(), :do_one_file)
    { :noreply, nil }
  end

  defp hash_of_file_at(path) do
    File.stream!(path, [], 1024*1024)
    |> Enum.reduce(
      :crypto.hash_init(:md5),
      fn (block, hash) ->
        :crypto.hash_update(hash, block)
      end)
    |> :crypto.hash_final()
  end
end
