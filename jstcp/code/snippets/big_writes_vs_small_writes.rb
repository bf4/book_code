#---
# Excerpted from "Working with TCP Sockets",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jstcp for more book information.
#---
require 'socket'
require 'benchmark'

# Both blocks below write 1MB of data 1000 times to a socket.
# The 'small writes' block does so in 1kb writes.
# The 'big writes' block does so in 100kb writes.

socket1 = TCPSocket.new('localhost', 4481)
socket2 = TCPSocket.new('localhost', 4481)

data1 = data2 = ['x'] * 1024 * 1024

Benchmark.bm do |x|
  x.report('small writes') do
    until data1.empty? do
      socket1.write(data1.shift(1024).join)
    end
  end

  x.report('big writes') do
    until data2.empty? do
      socket2.write(data2.shift(1024 * 100).join)
    end
  end
end

