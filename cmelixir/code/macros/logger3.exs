#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
defmodule Logger do
  defmacro debug(level, message) do
    quote unquote: true, bind_quoted: [message: message] do
      if is_binary(message) do
        IO.puts "#{unquote(level)}: #{message}"
      else
        IO.inspect "#{unquote(level)}: #{message}"
      end
    end
  end
end

