#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
defmodule Mod do
  defmacro definfo do
    IO.puts "In macro's context (#{__MODULE__})." 

    quote do
      IO.puts "In caller's context (#{__MODULE__})." 

      def friendly_info do
        IO.puts """
        My name is #{__MODULE__}
        My functions are #{inspect __info__(:functions)}
        """
      end
    end
  end
end

defmodule MyModule do
  require Mod
  Mod.definfo
end
