#---
# Excerpted from "Working with TCP Sockets",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jstcp for more book information.
#---
require 'socket'

module CloudHash
  class Server
    def initialize(port)
      # Create the underlying server socket.
      @server = TCPServer.new(port)
      puts "Listening on port #{@server.local_address.ip_port}"
      @storage = {}
    end

    def start
      # The familiar accept loop.
      Socket.accept_loop(@server) do |connection|
        handle(connection)
        connection.close
      end
    end

    def handle(connection)
      # Read from the connection until EOF.
      request = connection.read

      # Write back the result of the hash operation.
      connection.write process(request)
    end

    # Supported commands:
    # SET key value
    # GET key
    def process(request)
      command, key, value = request.split

      case command.upcase
      when 'GET'
        @storage[key]

      when 'SET'
        @storage[key] = value
      end
    end
  end
end

server = CloudHash::Server.new(4481)
server.start

