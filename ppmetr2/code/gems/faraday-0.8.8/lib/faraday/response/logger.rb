#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'forwardable'

module Faraday
  class Response::Logger < Response::Middleware
    extend Forwardable

    def initialize(app, logger = nil)
      super(app)
      @logger = logger || begin
        require 'logger'
        ::Logger.new(STDOUT)
      end
    end

    def_delegators :@logger, :debug, :info, :warn, :error, :fatal

    def call(env)
      info "#{env[:method]} #{env[:url].to_s}"
      debug('request') { dump_headers env[:request_headers] }
      super
    end

    def on_complete(env)
      info('Status') { env[:status].to_s }
      debug('response') { dump_headers env[:response_headers] }
    end

    private

    def dump_headers(headers)
      headers.map { |k, v| "#{k}: #{v.inspect}" }.join("\n")
    end
  end
end
