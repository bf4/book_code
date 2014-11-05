#---
# Excerpted from "Working with TCP Sockets",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jstcp for more book information.
#---
for_reading = [<TCPSocket>, <TCPSocket>, <TCPSocket>]
for_writing = [<TCPSocket>, <TCPSocket>, <TCPSocket>]

ready = IO.select(for_reading, for_writing, for_writing)

# One Array is returned for each Array passed in as an argument.
# In this case none of the connections in for_writing were writable
# and one of connections in for_reading was readable.
puts ready #=> [[<TCPSocket>], [], []]

