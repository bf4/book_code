#---
# Excerpted from "Programming Elixir ≥ 1.6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir16 for more book information.
#---
defmodule Duper.PathFinder do
  use GenServer

  @me PathFinder
  
  def start_link(root) do
    GenServer.start_link(__MODULE__, root, name: @me)
  end

  def next_path() do
    GenServer.call(@me, :next_path)
  end


  def init(path) do
    DirWalker.start_link(path)
  end

  def handle_call(:next_path, _from, dir_walker) do
    path = case DirWalker.next(dir_walker) do
             [ path ] -> path
             other    -> other
           end
    
    { :reply, path, dir_walker }
  end
  
end
