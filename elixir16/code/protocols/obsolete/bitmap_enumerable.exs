#---
# Excerpted from "Programming Elixir ≥ 1.6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir16 for more book information.
#---
defmodule Bitmap do
  defstruct value: 0

  @doc """
  A simple accessor for the 2^bit value in an integer

      iex> b = %Bitmap{value: 5}
      %Bitmap{value: 5}
      iex> Bitmap.fetch_bit(b,2)
      1
      iex> Bitmap.fetch_bit(b,1)
      0
      iex> Bitmap.fetch_bit(b,0)
      1
  """
  def fetch_bit(%Bitmap{value: value}, bit) do
    use Bitwise

    (value >>> bit) &&& 1
  end
end

defmodule Wrapper do
  
defimpl Enumerable,  for: Bitmap do
  import :math, only: [log: 1]

  def reduce(bitmap, {:cont, acc}, fun) do
    bit_count =  Enum.count(bitmap)
    _reduce({bitmap, bit_count}, { :cont, acc }, fun)
  end

  defp _reduce({_bitmap, -1}, { :cont, acc }, _fun), do: { :done, acc }

  defp _reduce({bitmap, bit_number}, { :cont, acc }, fun) do
    with bit = Bitmap.fetch_bit(bitmap, bit_number),
    do:  _reduce({bitmap, bit_number-1}, fun.(bit, acc), fun)
  end

  defp _reduce({_bitmap, _bit_number}, { :halt, acc }, _fun), do: { :halted, acc }

  defp _reduce({bitmap, bit_number}, { :suspend, acc }, fun), 
  do: { :suspended, acc, &_reduce({bitmap, bit_number}, &1, fun), fun } 

  def member?(value, bit_number) do
    { :ok, 0 <= bit_number && bit_number < Enum.count(value) }
  end

  def count(%Bitmap{value: value}) do              
    { :ok, bit_count(value) }
  end

  def slice(bitmap = %Bitmap{value: value}) do
    IO.inspect {
      :ok,
      bit_count(value),
      fn (start, length) ->
        slice_bitmap(bitmap, start-1, length+1h )
      end
    }
  end


  defp bit_count(value) do
    trunc(log(abs(value))/log(2)) + 1
  end

  defp slice_bitmap(value, start, length) do
    Enum.to_list(value)
    |> Enum.slice(start, length)
  end
end


fifty = %Bitmap{value: 50}

IO.puts Enum.count fifty    # => 6

IO.puts Enum.member? fifty, 4    # => true
IO.puts Enum.member? fifty, 6    # => false

IO.inspect Enum.reverse fifty       # => [0, 1, 0, 0, 1, 1, 0]
IO.inspect Enum.join fifty, ":"     # => "0:1:1:0:0:1:0"

end
