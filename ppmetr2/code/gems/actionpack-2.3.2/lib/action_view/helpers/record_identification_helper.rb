#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActionView
  module Helpers
    module RecordIdentificationHelper
      # See ActionController::RecordIdentifier.partial_path -- this is just a delegate to that for convenient access in the view.
      def partial_path(*args, &block)
        ActionController::RecordIdentifier.partial_path(*args, &block)
      end

      # See ActionController::RecordIdentifier.dom_class -- this is just a delegate to that for convenient access in the view.
      def dom_class(*args, &block)
        ActionController::RecordIdentifier.dom_class(*args, &block)
      end

      # See ActionController::RecordIdentifier.dom_id -- this is just a delegate to that for convenient access in the view.
      def dom_id(*args, &block)
        ActionController::RecordIdentifier.dom_id(*args, &block)
      end
    end
  end
end