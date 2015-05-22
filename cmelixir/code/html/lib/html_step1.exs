#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
defmodule Html do

  defmacro markup(do: block) do 
    quote do
      {:ok, var!(buffer, Html)} = start_buffer([])
      unquote(block)
      result = render(var!(buffer, Html))
      :ok = stop_buffer(var!(buffer, Html))
      result
    end
  end

  def start_buffer(state), do: Agent.start_link(fn -> state end) 

  def stop_buffer(buff), do: Agent.stop(buff)

  def put_buffer(buff, content), do: Agent.update(buff, &[content | &1]) 

  def render(buff), do: Agent.get(buff, &(&1)) |> Enum.reverse |> Enum.join("") 

  defmacro tag(name, do: inner) do 
    quote do
      put_buffer var!(buffer, Html), "<#{unquote(name)}>"
      unquote(inner)
      put_buffer var!(buffer, Html), "</#{unquote(name)}>"
    end
  end

  defmacro text(string) do 
    quote do: put_buffer(var!(buffer, Html), to_string(unquote(string)))
  end
end
