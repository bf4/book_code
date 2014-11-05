#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Faraday
  class Response::RaiseError < Response::Middleware
    def on_complete(env)
      case env[:status]
      when 404
        raise Faraday::Error::ResourceNotFound, response_values(env)
      when 407
        # mimic the behavior that we get with proxy requests with HTTPS
        raise Faraday::Error::ConnectionFailed, %{407 "Proxy Authentication Required "}
      when 400...600
        raise Faraday::Error::ClientError, response_values(env)
      end
    end

    def response_values(env)
      {:status => env[:status], :headers => env[:response_headers], :body => env[:body]}
    end
  end
end
