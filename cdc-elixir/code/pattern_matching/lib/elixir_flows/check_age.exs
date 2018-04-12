#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
{age, _} = Integer.parse IO.gets("Person's age:\n")

result = cond do
 age < 13 -> "kid"
 age <= 18 -> "teen"
 age > 18 -> "adult"
end

IO.puts "Result: #{result}"
