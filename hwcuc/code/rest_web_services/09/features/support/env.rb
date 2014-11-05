#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
require 'childprocess'
require 'timeout'
require 'httparty'

server = ChildProcess.build("rackup", "--port", "9999")
server.start
Timeout.timeout(3) do
  loop do
    begin
      HTTParty.get('http://localhost:9999')
      break
    rescue Errno::ECONNREFUSED => try_again
      sleep 0.1
    end
  end
end

at_exit do
  server.stop
end
