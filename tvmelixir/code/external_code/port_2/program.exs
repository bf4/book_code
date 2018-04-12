#---
# Excerpted from "Adopting Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/tvmelixir for more book information.
#---
port = Port.open({:spawn, "elixir all_caps.exs"}, [:binary, packet: 4])

Port.command(port, "command without newline")
receive do
  {^port, {:data, data}} ->
    IO.puts "Got: #{data}"
end

Port.close(port)
IO.puts "Closed"
