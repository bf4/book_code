#---
# Excerpted from "Working with Unix Processes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsunix for more book information.
#---
module Spyglass

  class Server
    include Singleton
    include Logging

    def start
      # Opens the main listening socket for the server. Now the server is responsive to
      # incoming connections.
      sock = TCPServer.open(Config.host, Config.port)
      out "Listening on port #{Config.host}:#{Config.port}"

      Lookout.instance.start(sock)
    end
  end
end

