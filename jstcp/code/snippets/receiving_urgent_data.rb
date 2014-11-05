#---
# Excerpted from "Working with TCP Sockets",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jstcp for more book information.
#---
require 'socket'

Socket.tcp_server_loop(4481) do |connection|
  # receive urgent data first
  urgent_data = connection.recv(1, Socket::MSG_OOB)

  data = connection.readpartial(1024)
end

