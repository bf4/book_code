#---
# Excerpted from "Adopting Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/tvmelixir for more book information.
#---
port = Port.open({:spawn, "elixir all_caps.exs"}, [:binary])

send port, {self(), {:command, "hello\n"}}
receive do
  {^port, {:data, data}} ->
    IO.puts "Got: #{data}"
end

send port, {self(), :close}
receive do
  {^port, :closed} ->
    IO.puts "Closed"
end
