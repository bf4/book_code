#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActionController
  class RewindableInput
    class RewindableIO < ActiveSupport::BasicObject
      def initialize(io)
        @io = io
        @rewindable = io.is_a?(::StringIO)
      end

      def method_missing(method, *args, &block)
        unless @rewindable
          @io = ::StringIO.new(@io.read)
          @rewindable = true
        end

        @io.__send__(method, *args, &block)
      end
    end

    def initialize(app)
      @app = app
    end

    def call(env)
      env['rack.input'] = RewindableIO.new(env['rack.input'])
      @app.call(env)
    end
  end
end
