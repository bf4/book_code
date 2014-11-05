#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Rack
  # *Handlers* connect web servers with Rack.
  #
  # Rack includes Handlers for Mongrel, WEBrick, FastCGI, CGI, SCGI
  # and LiteSpeed.
  #
  # Handlers usually are activated by calling <tt>MyHandler.run(myapp)</tt>.
  # A second optional hash can be passed to include server-specific
  # configuration.
  module Handler
    def self.get(server)
      return unless server

      if klass = @handlers[server]
        obj = Object
        klass.split("::").each { |x| obj = obj.const_get(x) }
        obj
      else
        Rack::Handler.const_get(server.capitalize)
      end
    end

    def self.register(server, klass)
      @handlers ||= {}
      @handlers[server] = klass
    end

    autoload :CGI, "rack/handler/cgi"
    autoload :FastCGI, "rack/handler/fastcgi"
    autoload :Mongrel, "rack/handler/mongrel"
    autoload :EventedMongrel, "rack/handler/evented_mongrel"
    autoload :SwiftipliedMongrel, "rack/handler/swiftiplied_mongrel"
    autoload :WEBrick, "rack/handler/webrick"
    autoload :LSWS, "rack/handler/lsws"
    autoload :SCGI, "rack/handler/scgi"
    autoload :Thin, "rack/handler/thin"

    register 'cgi', 'Rack::Handler::CGI'
    register 'fastcgi', 'Rack::Handler::FastCGI'
    register 'mongrel', 'Rack::Handler::Mongrel'
    register 'emongrel', 'Rack::Handler::EventedMongrel'
    register 'smongrel', 'Rack::Handler::SwiftipliedMongrel'
    register 'webrick', 'Rack::Handler::WEBrick'
    register 'lsws', 'Rack::Handler::LSWS'
    register 'scgi', 'Rack::Handler::SCGI'
    register 'thin', 'Rack::Handler::Thin'
  end
end
