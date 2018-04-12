#---
# Excerpted from "Programming Elixir ≥ 1.6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir16 for more book information.
#---
def no_vowels(string) do
  string
  |> String.replace(~r/[aeiou]/, "*")
end

def separator(column_widths) do
  map_join(column_widths, "-+-", fn width ->
    List.duplicate("-", width)
  end)
end
