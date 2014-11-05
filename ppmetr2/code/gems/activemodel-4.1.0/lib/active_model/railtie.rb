#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require "active_model"
require "rails"

module ActiveModel
  class Railtie < Rails::Railtie # :nodoc:
    config.eager_load_namespaces << ActiveModel

    initializer "active_model.secure_password" do
      ActiveModel::SecurePassword.min_cost = Rails.env.test?
    end
  end
end
