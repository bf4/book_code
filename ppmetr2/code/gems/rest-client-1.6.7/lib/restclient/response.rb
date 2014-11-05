#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module RestClient

  # A Response from RestClient, you can access the response body, the code or the headers.
  #
  module Response

    include AbstractResponse

    attr_accessor :args, :body, :net_http_res

    def body
      self
    end

    def Response.create body, net_http_res, args
      result = body || ''
      result.extend Response
      result.net_http_res = net_http_res
      result.args = args
      result
    end

  end
end
