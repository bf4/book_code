#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
# Includes +url_for+ into the host class (e.g. an abstract controller or mailer). The class
# has to provide a +RouteSet+ by implementing the <tt>_routes</tt> methods. Otherwise, an
# exception will be raised.
#
# Note that this module is completely decoupled from HTTP - the only requirement is a valid 
# <tt>_routes</tt> implementation.
module AbstractController
  module UrlFor
    extend ActiveSupport::Concern
    include ActionDispatch::Routing::UrlFor

    def _routes
      raise "In order to use #url_for, you must include routing helpers explicitly. " \
            "For instance, `include Rails.application.routes.url_helpers"
    end

    module ClassMethods
      def _routes
        nil
      end

      def action_methods
        @action_methods ||= begin
          if _routes
            super - _routes.named_routes.helper_names
          else
            super
          end
        end
      end
    end
  end
end
