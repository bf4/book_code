#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
defmodule Logger do
  defmacro debug(message) do
    quote do
      if is_binary(unquote(message)) do
        IO.puts unquote(message)
      else
        IO.inspect unquote(message)
      end
    end
  end
end

