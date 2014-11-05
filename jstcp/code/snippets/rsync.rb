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

# Socket#sysread is the same as #readpartial, except that it skips any 
# of Ruby's internal buffering and goes straight to the OS kernel.
socket.sysread(4096)

# Socket#sync defaults to false.
# When set to true any internal buffering done by Ruby is skipped, 
# calls are sent to the OS kernel immediately. Including reads.
socket.sync #=> false
socket.sync = true

