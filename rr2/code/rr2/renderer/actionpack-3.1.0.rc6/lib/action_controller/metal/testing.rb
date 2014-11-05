#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActionController
  module Testing
    extend ActiveSupport::Concern

    include RackDelegation

    def recycle!
      @_url_options = nil
    end


    # TODO: Clean this up
    def process_with_new_base_test(request, response)
      @_request = request
      @_response = response
      @_response.request = request
      ret = process(request.parameters[:action])
      if cookies = @_request.env['action_dispatch.cookies']
        cookies.write(@_response)
      end
      @_response.prepare!
      ret
    end

    # TODO : Rewrite tests using controller.headers= to use Rack env
    def headers=(new_headers)
      @_response ||= ActionDispatch::Response.new
      @_response.headers.replace(new_headers)
    end

    module ClassMethods
      def before_filters
        _process_action_callbacks.find_all{|x| x.kind == :before}.map{|x| x.name}
      end
    end
  end
end
