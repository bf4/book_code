#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
defmodule Html2 do
  use GenServer

  @external_resource tags_path = Path.join([__DIR__, "tags.txt"])
  @tags (for line <- File.stream!(tags_path, [], :line) do
    line |> String.strip |> String.to_atom
  end)

  defmacro markup(do: block) do
    quote do
      var!(buffer) = start_buffer([])
      unquote(Macro.postwalk(block, &postwalk/1))
      flush_buffer(var!(buffer))
    end
  end

  def postwalk({:text, _meta, [string]}) do
    quote do: put_buffer(var!(buffer), to_string(unquote(string)))
  end
  def postwalk({tag_name, _meta, [[do: inner]]}) when tag_name in @tags do
    quote do: tag(unquote(tag_name), [], do: unquote(inner))
  end
  def postwalk({tag_name, _meta, [string]}) when tag_name in @tags do
    quote do: tag(unquote(tag_name), [], do: text(unquote(string)))
  end
  def postwalk({tag_name, _meta, [attrs, [do: inner]]}) when tag_name in @tags do
    quote do: tag(unquote(tag_name), unquote(attrs), do: unquote(inner))
  end
  def postwalk(ast), do: ast

  defmacro tag(name, attrs \\ [], do: inner) do
    quote do
      put_buffer var!(buffer), open_tag(unquote_splicing([name, attrs]))
      unquote(postwalk(inner))
      put_buffer var!(buffer), unquote("</#{name}>")
    end
  end

  def open_tag(name, []), do: "<#{name}>"
  def open_tag(name, attrs) do
    attr_html = for {key, val} <- attrs, into: "", do: " #{key}=\"#{val}\""
    "<#{name}#{attr_html}>"
  end

  def start_buffer(state) do
    {:ok, buffer} = GenServer.start_link(__MODULE__, state)
    # {:ok, buffer} = Agent.start_link fn -> state end
    buffer
  end

  def put_buffer(agent, content) do #, do: Agent.update(agent, &[content | &1])
    GenServer.cast(agent, {:push, content})
  end

  def flush_buffer(agent) do
    contents = GenServer.call(agent, :flush) |> Enum.reverse |> Enum.join("")
    contents
  end

  def handle_call(:flush, _from, buffer) do
    {:stop, :normal, buffer, []}
  end

  def handle_cast({:push, content}, buffer) do
    {:noreply, [content | buffer]}
  end
end


