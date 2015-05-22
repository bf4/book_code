#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
defmodule StringTransforms do
  defmacro __using__(_opts) do 
    quote do
      def title_case(str) do
        str
        |> String.split(" ")
        |> Enum.map(fn <<first::utf8, rest::binary>> ->
          String.upcase(List.to_string([first])) <> rest
        end)
        |> Enum.join(" ")
      end

      def dash_case(str) do
        str
        |> String.downcase
        |> String.replace(~r/[^\w]/, "-")
      end
      # ... hundreds of more lines of string transform functions
    end
  end
end

defmodule User do
  use StringTransforms 

  def friendly_id(user) do
    dash_case(user.name)   
  end
end

iex> User.friendly_id(%{name: "Elixir Lang"})
"elixir-lang"
