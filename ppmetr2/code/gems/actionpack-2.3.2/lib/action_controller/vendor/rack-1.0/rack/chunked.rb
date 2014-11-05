#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'rack/utils'

module Rack

  # Middleware that applies chunked transfer encoding to response bodies
  # when the response does not include a Content-Length header.
  class Chunked
    include Rack::Utils

    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)
      headers = HeaderHash.new(headers)

      if env['HTTP_VERSION'] == 'HTTP/1.0' ||
         STATUS_WITH_NO_ENTITY_BODY.include?(status) ||
         headers['Content-Length'] ||
         headers['Transfer-Encoding']
        [status, headers.to_hash, body]
      else
        dup.chunk(status, headers, body)
      end
    end

    def chunk(status, headers, body)
      @body = body
      headers.delete('Content-Length')
      headers['Transfer-Encoding'] = 'chunked'
      [status, headers.to_hash, self]
    end

    def each
      term = "\r\n"
      @body.each do |chunk|
        size = bytesize(chunk)
        next if size == 0
        yield [size.to_s(16), term, chunk, term].join
      end
      yield ["0", term, "", term].join
    end

    def close
      @body.close if @body.respond_to?(:close)
    end
  end
end
