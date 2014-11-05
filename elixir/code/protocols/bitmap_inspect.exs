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

  defimpl Inspect do
    def inspect(%Bitmap{value: value}, _opts) do
      "%Bitmap{#{value}=#{as_binary(value)}}"
    end
    defp as_binary(value) do
      to_string(:io_lib.format("~.2B", [value]))
    end
  end
end

fifty = %Bitmap{value: 50}

IO.inspect fifty                   # => %Bitmap{50=0110010}
IO.inspect fifty, structs: false   # => %{__struct__: Bitmap, value: 50}
