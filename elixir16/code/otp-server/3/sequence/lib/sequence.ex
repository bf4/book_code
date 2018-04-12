#---
# Excerpted from "Programming Elixir ≥ 1.6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir16 for more book information.
#---
defmodule Sequence do

  @server Sequence.Server
  
  def start_link(current_number) do
    GenServer.start_link(@server, current_number, name: @server)
  end

  def next_number do
    GenServer.call(@server, :next_number)
  end

  def increment_number(delta) do
    GenServer.cast(@server, {:increment_number, delta})
  end


end
