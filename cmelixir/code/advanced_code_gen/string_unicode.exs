#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---

# defmodule String.Unicode do
#   ...
#   def upcase(string), do: do_upcase(string) |> IO.iodata_to_binary
#
#   defp do_upcase("é" <> rest) do
#     :binary.bin_to_list("É") ++ do_upcase(rest)
#   end
#   defp do_upcase("ć" <> rest) do
#     :binary.bin_to_list("Ć") ++ do_upcase(rest)
#   end
#   ...
# end

# defmodule Str do
#   to_binary = fn
#     "" ->
#       nil
#     codepoints ->
#       codepoints = :binary.split(codepoints, " ", [:global])
#       Enum.reduce codepoints, "", fn(codepoint, acc) ->
#         acc <> << String.to_integer(codepoint, 16) :: utf8 >>
#       end
#   end
#
#   data_path = Path.join(__DIR__, "UnicodeData.txt")
#
#   {codes, whitespace} = Enum.reduce File.stream!(data_path), {[], []}, fn(line, {cacc, wacc}) ->
#     [ codepoint, _name, _category,
#       _class, bidi, _decomposition,
#       _numeric_1, _numeric_2, _numeric_3,
#       _bidi_mirror, _unicode_1, _iso,
#       upper, lower, title ] = :binary.split(line, ";", [:global])
#
#     title = :binary.part(title, 0, byte_size(title) - 1)
#
#     cond do
#       upper != "" or lower != "" or title != "" ->
#         {[{to_binary.(codepoint), to_binary.(upper), to_binary.(lower), to_binary.(title)} | cacc], wacc}
#       bidi in ["B", "S", "WS"] ->
#         {cacc, [to_binary.(codepoint) | wacc]}
#       true ->
#         {cacc, wacc}
#     end
#   end
#
#   def upcase(string), do: do_upcase(string) |> IO.iodata_to_binary
#
#   for {codepoint, upper, _lower, _title} <- codes, upper && upper != codepoint do
#     defp do_upcase(unquote(codepoint) <> rest) do
#       unquote(:binary.bin_to_list(upper)) ++ do_upcase(rest)
#     end
#   end
#
#   defp do_upcase(<< char, rest :: binary >>) do
#     [char|do_upcase(rest)]
#   end
#
#   defp do_upcase(""), do: []
#
# end
