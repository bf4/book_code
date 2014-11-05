#---
# Excerpted from "Working with TCP Sockets",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jstcp for more book information.
#---
require 'socket'

# Set up the parameters.
PORT_RANGE = 1..128
HOST = 'archive.org'
TIME_TO_WAIT = 5 # seconds

# Create a socket for each port and initiate the nonblocking
# connect.
sockets = PORT_RANGE.map do |port|
  socket = Socket.new(:INET, :STREAM)
  remote_addr = Socket.sockaddr_in(port, 'archive.org')

  begin
    socket.connect_nonblock(remote_addr)
  rescue Errno::EINPROGRESS
  end

  socket
end

# Set the expiration.
expiration = Time.now + TIME_TO_WAIT

loop do
  # We call IO.select and adjust the timeout each time so that we'll never
  # be waiting past the expiration.
  _, writable, _ = IO.select(nil, sockets, nil, expiration - Time.now)
  break unless writable

  writable.each do |socket|
    begin
      socket.connect_nonblock(socket.remote_address)
    rescue Errno::EISCONN
      # If the socket is already connected then we can count this as a success.
      puts "#{HOST}:#{socket.remote_address.ip_port} accepts connections..."
      # Remove the socket from the list so it doesn't continue to be
      # selected as writable.
      sockets.delete(socket)
    rescue Errno::EINVAL
      sockets.delete(socket)
    end
  end
end

