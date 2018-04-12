#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
defmodule Sum do
  def up_to(n), do: sum_up_to(n, 0)
  defp sum_up_to(0, sum), do: sum
  defp sum_up_to(n, sum), do: sum_up_to(n - 1, n + sum)
end

defmodule Math do
  def sum(list), do: sum_list(list, 0)
  defp sum_list([], sum), do: sum
  defp sum_list([head | tail], sum), do: sum_list(tail, head + sum)
end

defmodule Sort do
  def asc([]), do: []
  def asc([a]), do: [a]
  def asc(list) do
    half_size = div(Enum.count(list), 2)
    {list_a, list_b} = Enum.split(list, half_size)
    merge(
      asc(list_a),
      asc(list_b),
      []
    )
  end

  defp merge([], list_b, merged), do: merged ++ list_b
  defp merge(list_a, [], merged), do: merged ++ list_a
  defp merge([head_a | tail_a], list_b = [head_b | _], merged)
      when head_a <= head_b do
    merge(tail_a, list_b, merged ++ [head_a])
  end
  defp merge(list_a = [head_a | _], [head_b | tail_b], merged)
      when head_a > head_b do
    merge(list_a, tail_b, merged ++ [head_b])
  end
end
