#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
defmodule Assertion do

  defmacro assert({operator, _, [lhs, rhs]}) do
    quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs] do
      Assertion.Test.assert(operator, lhs, rhs)                     
    end
  end
end

defmodule Assertion.Test do                                         
  def assert(:==, lhs, rhs) when lhs == rhs do
    IO.write "."
  end
  def assert(:==, lhs, rhs) do
    IO.puts """
    FAILURE:
      Expected:       #{lhs}
      to be equal to: #{rhs}
    """
  end

  def assert(:>, lhs, rhs) when lhs > rhs do
    IO.write "."
  end
  def assert(:>, lhs, rhs) do
    IO.puts """
    FAILURE:
      Expected:           #{lhs}
      to be greater than: #{rhs}
    """
  end
end
