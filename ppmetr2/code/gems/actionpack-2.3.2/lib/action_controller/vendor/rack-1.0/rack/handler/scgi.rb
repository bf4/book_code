#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'scgi'
require 'stringio'
require 'rack/content_length'
require 'rack/chunked'

module Rack
  module Handler
    class SCGI < ::SCGI::Processor
      attr_accessor :app
      
      def self.run(app, options=nil)
        new(options.merge(:app=>app,
                          :host=>options[:Host],
                          :port=>options[:Port],
                          :socket=>options[:Socket])).listen
      end
      
      def initialize(settings = {})
        @app = Rack::Chunked.new(Rack::ContentLength.new(settings[:app]))
        @log = Object.new
        def @log.info(*args); end
        def @log.error(*args); end
        super(settings)
      end
        
      def process_request(request, input_body, socket)
        env = {}.replace(request)
        env.delete "HTTP_CONTENT_TYPE"
        env.delete "HTTP_CONTENT_LENGTH"
        env["REQUEST_PATH"], env["QUERY_STRING"] = env["REQUEST_URI"].split('?', 2)
        env["HTTP_VERSION"] ||= env["SERVER_PROTOCOL"]
        env["PATH_INFO"] = env["REQUEST_PATH"]
        env["QUERY_STRING"] ||= ""
        env["SCRIPT_NAME"] = ""
        env.update({"rack.version" => [0,1],
                     "rack.input" => StringIO.new(input_body),
                     "rack.errors" => $stderr,

                     "rack.multithread" => true,
                     "rack.multiprocess" => true,
                     "rack.run_once" => false,

                     "rack.url_scheme" => ["yes", "on", "1"].include?(env["HTTPS"]) ? "https" : "http"
                   })
        status, headers, body = app.call(env)
        begin
          socket.write("Status: #{status}\r\n")
          headers.each do |k, vs|
            vs.split("\n").each { |v| socket.write("#{k}: #{v}\r\n")}
          end
          socket.write("\r\n")
          body.each {|s| socket.write(s)}
        ensure
          body.close if body.respond_to? :close
        end
      end
    end
  end
end
