#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'lsapi'
require 'rack/content_length'

module Rack
  module Handler
    class LSWS
      def self.run(app, options=nil)
        while LSAPI.accept != nil
          serve app
        end
      end
      def self.serve(app)
        app = Rack::ContentLength.new(app)

        env = ENV.to_hash
        env.delete "HTTP_CONTENT_LENGTH"
        env["SCRIPT_NAME"] = "" if env["SCRIPT_NAME"] == "/"
        env.update({"rack.version" => [0,1],
                     "rack.input" => StringIO.new($stdin.read.to_s),
                     "rack.errors" => $stderr,
                     "rack.multithread" => false,
                     "rack.multiprocess" => true,
                     "rack.run_once" => false,
                     "rack.url_scheme" => ["yes", "on", "1"].include?(ENV["HTTPS"]) ? "https" : "http"
                   })
        env["QUERY_STRING"] ||= ""
        env["HTTP_VERSION"] ||= env["SERVER_PROTOCOL"]
        env["REQUEST_PATH"] ||= "/"
        status, headers, body = app.call(env)
        begin
          send_headers status, headers
          send_body body
        ensure
          body.close if body.respond_to? :close
        end
      end
      def self.send_headers(status, headers)
        print "Status: #{status}\r\n"
        headers.each { |k, vs|
          vs.split("\n").each { |v|
            print "#{k}: #{v}\r\n"
          }
        }
        print "\r\n"
        STDOUT.flush
      end
      def self.send_body(body)
        body.each { |part|
          print part
          STDOUT.flush
        }
      end
    end
  end
end
