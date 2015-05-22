#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
defmodule Debugger do
  defmacro log(expression) do
    if Application.get_env(:debugger, :log_level) == :debug do
      quote do
        IO.puts "================="
        IO.inspect unquote(expression) 
        IO.puts "================="
        unquote(expression)            
      end
    else
      expression
    end
  end
end
