#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
require 'gserver'

class LogServer < GServer

  def initialize
    super(12345)
  end

  def serve(client)
    client.puts get_end_of_log_file
  end


private

  def get_end_of_log_file
    File.open("/var/log/system.log") do |log|
      log.seek(-500, IO::SEEK_END)    # back up 500 characters from end
      log.gets                        # ignore partial line
      log.read                        # and return rest
    end
  end
end

server = LogServer.new
server.start.join
