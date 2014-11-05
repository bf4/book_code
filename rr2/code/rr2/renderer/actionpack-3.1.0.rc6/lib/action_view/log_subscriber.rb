#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActionView
  # = Action View Log Subscriber
  #
  # Provides functionality so that Rails can output logs from Action View.
  class LogSubscriber < ActiveSupport::LogSubscriber
    def render_template(event)
      message = "Rendered #{from_rails_root(event.payload[:identifier])}"
      message << " within #{from_rails_root(event.payload[:layout])}" if event.payload[:layout]
      message << (" (%.1fms)" % event.duration)
      info(message)
    end
    alias :render_partial :render_template
    alias :render_collection :render_template

    # TODO: Ideally, ActionView should have its own logger so it does not depend on AC.logger
    def logger
      ActionController::Base.logger if defined?(ActionController::Base)
    end

  protected

    def from_rails_root(string)
      string.sub("#{Rails.root}/", "").sub(/^app\/views\//, "")
    end
  end
end

ActionView::LogSubscriber.attach_to :action_view
