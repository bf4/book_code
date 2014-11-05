#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'action_dispatch'
require 'rack/utils'

module Rails
  module Rack
    # Sets the Content-Length header on responses with fixed-length bodies.
    class ContentLength
      include ::Rack::Utils

      def initialize(app, sendfile=nil)
        @app = app
        @sendfile = sendfile
      end

      def call(env)
        status, headers, body = @app.call(env)
        headers = HeaderHash.new(headers)

        if !STATUS_WITH_NO_ENTITY_BODY.include?(status.to_i) &&
           !headers['Content-Length'] &&
           !headers['Transfer-Encoding'] &&
           !(@sendfile && headers[@sendfile])

          old_body = body
          body, length = [], 0
          old_body.each do |part|
            body << part
            length += bytesize(part)
          end
          old_body.close if old_body.respond_to?(:close)
          headers['Content-Length'] = length.to_s
        end

        [status, headers, body]
      end
    end
  end
end