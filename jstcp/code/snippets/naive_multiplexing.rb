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

# We enter an endless loop.
loop do
  # For each connection...
  connections.each do |conn|
    begin
      # Attempt to read from each connection in a non-blocking way,
      # processing any data received, otherwise trying the next
      # connection.
      data = conn.read_nonblock(4096)
      process(data)
    rescue Errno::EAGAIN
    end
  end
end

