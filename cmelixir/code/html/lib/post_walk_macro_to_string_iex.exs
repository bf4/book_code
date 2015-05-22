#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
iex> c "html_macro_walk.exs"
[Html]

iex> import Html
nil

iex> ast = quote do
...>   markup do
...>     div do
...>       h1 do
...>         text "Some text"
...>       end
...>     end
...>   end
...> end

iex> ast |> Macro.expand(__ENV__) |> Macro.to_string |> IO.puts
(
  {:ok, var!(buffer, Html)} = start_buffer([])
  tag(:div, []) do
    tag(:h1, []) do
      put_buffer(var!(buffer, Html), to_string("Some text"))
    end
  end
  result = render(var!(buffer, Html))
  :ok = stop_buffer(var!(buffer, Html))
  result
)
:ok
