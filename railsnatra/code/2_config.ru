# We will simply use rubygems to set our load paths
require "rubygems"

# Require our dependencies
require "rails"
require "active_support/railtie"
require "action_controller/railtie"

require File.expand_path("../2_railsnatra", __FILE__)

class LoggerMiddleware
  def initialize(app, message)
    @app = app
    @message = message
  end

  def call(env)
    puts "REQUEST: #@message"
    @app.call(env)
  ensure
    puts "RESPONSE: #@message"
  end
end

class Endpoint < Railsnatra
  use LoggerMiddleware, "3 - railsnatra! \\m/"

  get "/world" do
    render text: "Yeah Railsnatra!\n"
  end
end

class SingleFile < Rails::Application
  # Set up production configuration
  config.eager_load = true
  config.cache_classes = true

  config.middleware.use LoggerMiddleware, "2 - rails app"

  # A key base is required for our app to boot
  config.secret_key_base = "pa34u13hsleuowi1aisejkez12u39201pluaep2ejlkwhkj"

  # Define a basic route
  routes.append do
    mount Endpoint, at: "/hello"
  end
end

SingleFile.initialize!

use LoggerMiddleware, "1 - web server"
run Rails.application
