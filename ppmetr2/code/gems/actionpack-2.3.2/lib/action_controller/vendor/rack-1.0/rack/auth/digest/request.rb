#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'rack/auth/abstract/request'
require 'rack/auth/digest/params'
require 'rack/auth/digest/nonce'

module Rack
  module Auth
    module Digest
      class Request < Auth::AbstractRequest

        def method
          @env['rack.methodoverride.original_method'] || @env['REQUEST_METHOD']
        end

        def digest?
          :digest == scheme
        end

        def correct_uri?
          (@env['SCRIPT_NAME'].to_s + @env['PATH_INFO'].to_s) == uri
        end

        def nonce
          @nonce ||= Nonce.parse(params['nonce'])
        end

        def params
          @params ||= Params.parse(parts.last)
        end

        def method_missing(sym)
          if params.has_key? key = sym.to_s
            return params[key]
          end
          super
        end

      end
    end
  end
end
