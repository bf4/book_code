#---
# Excerpted from "Adopting Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/tvmelixir for more book information.
#---
defmodule PathAllocator do
  use GenServer

  # Store the name in a module attribute for readability
  @name PathAllocator

  def start_link(tmp_dir) when is_binary(tmp_dir) do
    GenServer.start_link(__MODULE__, tmp_dir, name: @name)
  end

  def allocate do
    GenServer.call(@name, :allocate)
  end
  def init(tmp_dir) do
    Process.flag(:trap_exit, true)
    {:ok, {tmp_dir, %{}}}
  end
  def handle_call(:allocate, {pid, _}, {tmp_dir, refs}) do
    path = Path.join(tmp_dir, generate_random_filename())
    ref  = Process.monitor(pid)
    refs = Map.put(refs, ref, path)
    {:reply, path, {tmp_dir, refs}}
  end

  defp generate_random_filename do
    Base.url_encode64(:crypto.strong_rand_bytes(48))
  end

  def handle_info({:DOWN, ref, _, _, _}, {tmp_dir, refs}) do
    {path, refs} = Map.pop(refs, ref)
    File.rm(path)
    {:noreply, {tmp_dir, refs}}
  end

  def terminate(_reason, {_tmp_dir, refs}) do
    for {_, path} <- refs do
      File.rm(path)
    end
    :ok
  end
end
