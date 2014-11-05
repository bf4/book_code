#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActionController
  class AbstractResponse #:nodoc:
    DEFAULT_HEADERS = { "Cache-Control" => "no-cache" }
    attr_accessor :body, :headers, :session, :cookies, :assigns, :template, :redirected_to, :redirected_to_method_params

    def initialize
      @body, @headers, @session, @assigns = "", DEFAULT_HEADERS.merge("cookie" => []), [], []
    end

    def redirect(to_url, permanently = false)
      @headers["Status"]   = "302 Found" unless @headers["Status"] == "301 Moved Permanently"
      @headers["location"] = to_url

      @body = "<html><body>You are being <a href=\"#{to_url}\">redirected</a>.</body></html>"
    end
  end
end