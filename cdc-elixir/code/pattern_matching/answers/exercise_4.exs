#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
defmodule IncomeTax do
  def total(salary) when salary <= 2000, do: 0
  def total(salary) when salary <= 3000, do: salary * 0.05
  def total(salary) when salary <= 6000, do: salary * 0.1
  def total(salary), do: salary * 0.15
end

input =  IO.gets "Your salary:\n"

case Float.parse(input) do
 :error -> IO.puts "Invalid salary: #{input}"
 {salary, _} ->
   tax = IncomeTax.total(salary)
   IO.puts "Net wage: #{salary - tax} - Income tax: #{tax}"
end
