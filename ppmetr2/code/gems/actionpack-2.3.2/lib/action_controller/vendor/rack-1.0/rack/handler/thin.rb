#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require "thin"
require "rack/content_length"
require "rack/chunked"

module Rack
  module Handler
    class Thin
      def self.run(app, options={})
        app = Rack::Chunked.new(Rack::ContentLength.new(app))
        server = ::Thin::Server.new(options[:Host] || '0.0.0.0',
                                    options[:Port] || 8080,
                                    app)
        yield server if block_given?
        server.start
      end
    end
  end
end
