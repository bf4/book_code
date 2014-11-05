#---
# Excerpted from "Working with TCP Sockets",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jstcp for more book information.
#---
require 'socket'
one_kb = 1024 # bytes

Socket.tcp_server_loop(4481) do |connection|
  # Read data in chunks of 1 kb.
  while data = connection.read(one_kb) do
    puts data
  end

  connection.close
end

