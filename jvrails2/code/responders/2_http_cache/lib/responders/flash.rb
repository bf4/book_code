#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
module Responders
  module Flash
    def to_html
      set_flash_message! unless get?
      super
    end

    private

    def set_flash_message!
      status = has_errors? ? :alert : :notice
      return if controller.flash[status].present?

      message = i18n_lookup(status)
      controller.flash[status] = message if message.present?
    end

    def i18n_lookup(status)
      namespace = controller.controller_path.gsub("/", ".")
      action    = controller.action_name

      lookup  = [namespace, action, status].join(".").to_sym
      default = ["actions", action, status].join(".").to_sym

      I18n.t(lookup, scope: :flash, default: default,
             resource_name: resource.class.model_name.human)
    end
  end
end
