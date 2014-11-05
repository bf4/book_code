#---
# Excerpted from "Working with TCP Sockets",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jstcp for more book information.
#---
require 'socket'

socket = TCPSocket.new('google.com', 80)
# Get an instance of Socket::Option representing the type of the socket.
opt = socket.getsockopt(Socket::SOL_SOCKET, Socket::SO_TYPE)

# Compare the integer representation of the option to the integer 
# stored in Socket::SOCK_STREAM for comparison. 
opt.int == Socket::SOCK_STREAM #=> true
opt.int == Socket::SOCK_DGRAM #=> false

