#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'vcr/middleware/faraday'

module VCR
  class LibraryHooks
    # @private
    module Faraday
      # @private
      module BuilderClassExtension
        def new(*args)
          super.extend BuilderInstanceExtension
        end

        ::Faraday::Builder.extend self
      end

      # @private
      module BuilderInstanceExtension
        def lock!(*args)
          insert_vcr_middleware
          super
        end

      private

        def insert_vcr_middleware
          return if handlers.any? { |h| h.klass == VCR::Middleware::Faraday }
          adapter_index = handlers.index { |h| h.klass < ::Faraday::Adapter }
          adapter_index ||= handlers.size
          warn_about_after_adapter_middleware(adapter_index)
          insert_before(adapter_index, VCR::Middleware::Faraday)
        end

        def warn_about_after_adapter_middleware(adapter_index)
          after_adapter_middleware_count = (handlers.size - adapter_index - 1)
          return if after_adapter_middleware_count < 1

          after_adapter_middlewares = handlers.last(after_adapter_middleware_count)
          warn "WARNING: The Faraday connection stack contains middleware after " +
               "the HTTP adapter (#{after_adapter_middlewares.map(&:inspect).join(', ')}). " +
               "This is a non-standard configuration and VCR may not be able to " +
               "record the HTTP requests made through this Faraday connection."
        end
      end
    end
  end
end

