#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
defmodule Html do

  Module.register_attribute(__MODULE__, :tags, accumulate: true)
  @external_resource tags_path = Path.join([__DIR__, "tags.txt"])
  for line <- File.stream!(tags_path, [], :line) do
    name = line |> String.strip |> String.to_atom
    @tags name
  end

  defmacro markup(do: block) do
    ast = Macro.postwalk(block, &postwalk/1)
    IO.inspect ast
    IO.puts Macro.to_string(ast)
    # {_, _, inner} = ast
    # ast = Enum.reduce inner, "", fn block, acc ->
    #   quote do: to_string(unquote(acc)) <> to_string(unquote(block))
    # end
    # # IO.inspect ast
    # IO.puts Macro.to_string(ast)
    ast
  end

  def postwalk({:text, meta, [inner]}) do
    quote do: [unquote(inner)]
  end
  def postwalk({tag, meta, [[do: inner]]}) when tag in @tags do
    quote do
      [unquote("<#{tag}>"), unquote(postwalk(inner)), unquote("</#{tag}>")]
    end
  end
  def postwalk(ast) do
    ast
  end

  def to_s(list) when is_list(list), do: Enum.join(list, "")
  def to_s(inner), do: to_string(inner)

#
#   defmacro tag(name, attrs) do
#     quote do
#       tag unquote(name), unquote(Dict.drop(attrs, [:do])), do: unquote(attrs[:do])
#     end
#   end
#   defmacro tag(name, attrs, do: block) do
#     quote unquote: true, bind_quoted: [name: name, attrs: attrs] do
#       [open_tag(name, attrs),
#        unquote(block),
#        close_tag(name)]
#     end
#   end
#
#   defmacro text(string) do
#     quote do: to_string(unquote(string))
#   end
#
#   defmacro open_tag(name, _attrs) do
#     quote do: "<#{unquote(name)}>"
#   end
#
#   defmacro close_tag(name) do
#     quote do: "</#{unquote(name)}>"
#   end
end
