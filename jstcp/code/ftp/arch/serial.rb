#---
# Excerpted from "Working with TCP Sockets",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jstcp for more book information.
#---
require 'socket'
require_relative '../command_handler'

module FTP
  CRLF = "\r\n"

  class Serial
    def initialize(port = 21)
      @control_socket = TCPServer.new(port)
      trap(:INT) { exit }
    end

    def gets
      @client.gets(CRLF)
    end

    def respond(message)
      @client.write(message)
      @client.write(CRLF)
    end

    def run
      loop do
        @client = @control_socket.accept
        respond "220 OHAI"

        handler = CommandHandler.new(self)

        loop do
          request = gets

          if request
            respond handler.handle(request)
          else
            @client.close
            break
          end
        end
      end
    end
  end
end

server = FTP::Serial.new(4481)
server.run

