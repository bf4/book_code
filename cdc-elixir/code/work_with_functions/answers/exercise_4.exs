#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
apply_tax = fn price ->
  tax = price * 0.12
  IO.puts "Price: #{price + tax} - Tax: #{tax}"
end

Enum.each [12.5, 30.99, 250.49, 18.80], apply_tax
