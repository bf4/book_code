#---
# Excerpted from "Working with TCP Sockets",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jstcp for more book information.
#---

# Given an Array of connections.
connections = [<TCPSocket>, <TCPSocket>, <TCPSocket>]

loop do
  # Ask select(2) which connections are ready for reading.
  ready = IO.select(connections)

  # Read data only from the available connections.
  readable_connections = ready[0]
  readable_connections.each do |conn|
    data = conn.readpartial(4096)
    process(data)
  end
end

