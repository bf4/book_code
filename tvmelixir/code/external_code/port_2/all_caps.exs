#---
# Excerpted from "Adopting Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/tvmelixir for more book information.
#---
for length_binary <- IO.stream(:stdio, 4) do
  <<length::32>> = length_binary
  all_caps = length |> IO.read() |> String.upcase()
  IO.write <<byte_size(all_caps)::32, all_caps::binary>>
end
