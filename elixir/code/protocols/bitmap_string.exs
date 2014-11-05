#---
# Excerpted from "Programming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/elixir for more book information.
#---
defmodule Bitmap do
  defstruct value: 0

  defimpl String.Chars do
    def to_string(value), do: Enum.join(value, "")
  end
end

fifty = %Bitmap{value: 50}

IO.puts "Fifty in bits is #{fifty}"  # => Fifty in bits is 0110010
