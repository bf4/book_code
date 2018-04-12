#---
# Excerpted from "Programming Elixir ≥ 1.6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir16 for more book information.
#---
defimpl String.Chars, for: Bitmap do
  def to_string(bitmap) do
    import Enum
    bitmap
    |> reverse
    |> chunk(3)
    |> map(fn three_bits -> three_bits |> reverse |> join end)
    |> reverse
    |> join("_")
  end
end
