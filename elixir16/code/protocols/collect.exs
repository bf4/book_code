#---
# Excerpted from "Programming Elixir ≥ 1.6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir16 for more book information.
#---
defimpl Collectable, for: Integer do
  def into(original) do
    {[], fn
      list, {:cont, x} -> [x|list]
      list, :done -> original ++ :lists.reverse(list)
      _, :halt -> :ok
    end}
  end
end

IO.inspect Enum.into(3, [])
