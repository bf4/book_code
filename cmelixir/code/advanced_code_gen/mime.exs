#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
defmodule Mime do
  for line <- File.stream!(Path.join([__DIR__, "mimes.txt"]), [], :line) do    
    [type, rest] = line |> String.split("\t") |> Enum.map(&String.strip(&1))
    extensions = String.split(rest, ~r/,\s?/)

    def exts_from_type(unquote(type)), do: unquote(extensions)                 
    def type_from_ext(ext) when ext in unquote(extensions), do: unquote(type)  
  end

  def exts_from_type(_type), do: []                                            
  def type_from_ext(_ext), do: nil
  def valid_type?(type), do: exts_from_type(type) |> Enum.any?
end
