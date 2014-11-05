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
  # Simplest way to read data from the connection.
  puts connection.read

  # Close the connection once we're done reading. Lets the client
  # know that they can stop waiting for us to write something back.
  connection.close
end

