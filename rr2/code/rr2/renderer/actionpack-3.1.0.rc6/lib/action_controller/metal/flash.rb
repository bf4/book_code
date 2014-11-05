#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActionController #:nodoc:
  module Flash
    extend ActiveSupport::Concern

    included do
      delegate :flash, :to => :request
      delegate :alert, :notice, :to => "request.flash"
      helper_method :alert, :notice
    end

    protected
      def redirect_to(options = {}, response_status_and_flash = {}) #:doc:
        if alert = response_status_and_flash.delete(:alert)
          flash[:alert] = alert
        end

        if notice = response_status_and_flash.delete(:notice)
          flash[:notice] = notice
        end

        if other_flashes = response_status_and_flash.delete(:flash)
          flash.update(other_flashes)
        end

        super(options, response_status_and_flash)
      end
  end
end
