# We will simply use rubygems to set our load paths
require "rubygems"

# Require our dependencies
require "rails"
require "active_support/railtie"
require "action_controller/railtie"

require File.expand_path("../3_railsnatra", __FILE__)

class Endpoint < Railsnatra
  prepend_view_path File.expand_path("../views", __FILE__)

  get "/world" do
    render template: "sample"
  end

  private

  def hi
    "something else"
  end
end

class SingleFile < Rails::Application
  # Set up production configuration
  config.eager_load = true
  config.cache_classes = true

  # A key base is required for our app to boot
  config.secret_key_base = "pa34u13hsleuowi1aisejkez12u39201pluaep2ejlkwhkj"

  # Define a basic route
  routes.append do
    mount Endpoint, at: "/hello"
  end
end

SingleFile.initialize!
run Rails.application
