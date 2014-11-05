#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActionDispatch
  # Integration test methods such as ActionDispatch::Integration::Session#get
  # and ActionDispatch::Integration::Session#post return objects of class
  # TestResponse, which represent the HTTP response results of the requested
  # controller actions.
  #
  # See Response for more information on controller response objects.
  class TestResponse < Response
    def self.from_response(response)
      new.tap do |resp|
        resp.status  = response.status
        resp.headers = response.headers
        resp.body    = response.body
      end
    end

    # Was the response successful?
    alias_method :success?, :successful?

    # Was the URL not found?
    alias_method :missing?, :not_found?

    # Were we redirected?
    alias_method :redirect?, :redirection?

    # Was there a server-side error?
    alias_method :error?, :server_error?
  end
end
