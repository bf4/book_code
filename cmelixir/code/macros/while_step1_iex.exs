#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
iex(1)> c "while.exs"
[Loop]
iex(2)> import Loop
nil
iex(3)> while true do
...(3)>   IO.puts "looping!"
...(3)> end
looping!
looping!
looping!
looping!
looping!
looping!
...
^C^C
