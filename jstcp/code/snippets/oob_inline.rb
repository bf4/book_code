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
  # receive urgent data inline with 'regular' data
  connection.setsockopt :SOCKET, :OOBINLINE, true

  # note that the read stops when it 
  # encounters urgent data
  connection.readpartial(1024) #=> 'foo'
  connection.readpartial(1024) #=> '!'
end


