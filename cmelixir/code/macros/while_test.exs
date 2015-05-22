#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
ExUnit.start
Code.require_file("while.exs", __DIR__)

defmodule WhileTest do
  use ExUnit.Case
  import Loop

  test "while/2 loops as long as the expression is truthy" do
    pid = spawn(fn -> :timer.sleep(:infinity) end) 

    send self, :one
    while Process.alive?(pid) do                   
      receive do
        :one -> send self, :two
        :two -> send self, :three
        :three ->
          Process.exit(pid, :kill)                 
          send self, :done
      end
    end
    assert_received :done                          
  end

  test "break/0 terminates execution" do
    send self, :one
    while true do
      receive do
        :one -> send self, :two
        :two -> send self, :three
        :three ->
          send self, :done                         
          break                                    
      end
    end
    assert_received :done
  end
end
