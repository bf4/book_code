#---
# Excerpted from "Working with Unix Processes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsunix for more book information.
#---
require 'time'
require 'rack/utils'

# Worker
# ======
#
module Spyglass
  class Worker
    include Logging

    def initialize(socket, app, writable_pipe, connection = nil)
      @socket, @app, @writable_pipe = socket, app, writable_pipe
      @parser = Spyglass::HttpParser.new

      handle_connection(connection) if connection
    end

    def start
      trap_signals

      loop do
        handle_connection @socket.accept
      end
    end

    def handle_connection(conn)
      verbose "Received connection"
      # This notifies our Master that we have received a connection, expiring
      # it's `IO.select` and preventing it from timing out.
      @writable_pipe.write_nonblock('.')

      # This clears any state that the http parser has lying around
      # from the last connection that was handled.
      @parser.reset

      # The Rack spec requires that 'rack.input' be encoded as ASCII-8BIT.
      empty_body = ''
      empty_body.encode!(Encoding::ASCII_8BIT) if empty_body.respond_to?(:encode!)

      # The Rack spec requires that the env contain certain keys before being
      # passed to the app. These are the keys that aren't provided by each
      # incoming request, server-specific stuff.
      env = { 
        'rack.input' => StringIO.new(empty_body),
        'rack.multithread' => false,
        'rack.multiprocess' => true,
        'rack.run_once' => false,
        'rack.errors' => STDERR,
        'rack.version' => [1, 0]
      }

      # This reads data in from the client connection. We'll read up to 
      # 10000 bytes at the moment.
      data = conn.readpartial(10000)
      # Here we pass the data and the env into the http parser. It parses
      # the raw http request data and updates the env with all of the data
      # it can withdraw.
      @parser.execute(env, data, 0)

      # Call the Rack app, goes all the way down the rabbit hole and back again.
      status, headers, body = @app.call(env)

      # These are the default headers we always include in a response. We
      # only speak HTTP 1.1 and we always close the client connection. At 
      # the monment keepalive is not supported.
      head = "HTTP/1.1 #{status}\r\n" \
      "Date: #{Time.now.httpdate}\r\n" \
      "Status: #{Rack::Utils::HTTP_STATUS_CODES[status]}\r\n" \
      "Connection: close\r\n"

      headers.each do |k,v|
        head << "#{k}: #{v}\r\n"
      end
      conn.write "#{head}\r\n"

      body.each { |chunk| conn.write chunk }
      body.close if body.respond_to?(:close)
      # Since keepalive is not supported we can close the client connection
      # immediately after writing the body.
      conn.close

      verbose "Closed connection"
    end

    def trap_signals
      trap(:QUIT) do
        out "Received QUIT"
        exit
      end
    end
  end
end

