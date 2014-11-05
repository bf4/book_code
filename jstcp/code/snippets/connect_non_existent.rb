#---
# Excerpted from "Working with TCP Sockets",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jstcp for more book information.
#---
require 'socket'

socket = Socket.new(:INET, :STREAM)

# Attempt to connect to google.com on the known gopher port.
remote_addr = Socket.pack_sockaddr_in(70, 'google.com')
socket.connect(remote_addr)

