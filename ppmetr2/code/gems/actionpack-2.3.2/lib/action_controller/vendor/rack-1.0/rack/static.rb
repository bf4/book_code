#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Rack

  # The Rack::Static middleware intercepts requests for static files
  # (javascript files, images, stylesheets, etc) based on the url prefixes
  # passed in the options, and serves them using a Rack::File object. This
  # allows a Rack stack to serve both static and dynamic content.
  #
  # Examples:
  #     use Rack::Static, :urls => ["/media"]
  #     will serve all requests beginning with /media from the "media" folder
  #     located in the current directory (ie media/*).
  #
  #     use Rack::Static, :urls => ["/css", "/images"], :root => "public"
  #     will serve all requests beginning with /css or /images from the folder
  #     "public" in the current directory (ie public/css/* and public/images/*)

  class Static

    def initialize(app, options={})
      @app = app
      @urls = options[:urls] || ["/favicon.ico"]
      root = options[:root] || Dir.pwd
      @file_server = Rack::File.new(root)
    end

    def call(env)
      path = env["PATH_INFO"]
      can_serve = @urls.any? { |url| path.index(url) == 0 }

      if can_serve
        @file_server.call(env)
      else
        @app.call(env)
      end
    end

  end
end
