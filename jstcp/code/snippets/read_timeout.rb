#---
# Excerpted from "Working with TCP Sockets",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jstcp for more book information.
#---
require 'socket'
require 'timeout'

timeout = 5 # seconds

Socket.tcp_server_loop(4481) do |connection|

  begin
    # Initiate the initial read(2). This is important because
    # it requires data be requested on the socket and circumvents
    # a select(2) call when there's already data available to read.
    connection.read_nonblock(4096)

  rescue Errno::EAGAIN
    # Monitor the connection to see if it becomes readable.
    if IO.select([connection], nil, nil, timeout)
      # IO.select will actually return our socket, but we
      # don't care about the return value. The fact that
      # it didn't return nil means that our socket is readable.
      retry

    else
      raise Timeout::Error
    end
  end

  connection.close
end

