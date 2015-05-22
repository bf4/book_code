#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
defmodule Assertion do
  # ...
  defmacro extend(options \\ []) do       
    quote do
      import unquote(__MODULE__)

      def run do
        IO.puts "Running the tests..."
      end
    end
  end
  # ...
end

defmodule MathTest do
  require Assertion
  Assertion.extend
end
