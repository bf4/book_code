#---
# Excerpted from "Working with TCP Sockets",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jstcp for more book information.
#---
require 'socket'

Socket.tcp('google.com', 80) do |connection|
  connection.write "GET / HTTP/1.1\r\n"
  connection.close
end

# Omitting the block argument behaves the same
# as TCPSocket.new().
client = Socket.tcp('google.com', 80)

