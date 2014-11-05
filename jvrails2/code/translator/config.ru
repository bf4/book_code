# We will simply use rubygems to set our load paths
require "rubygems"
# Require our dependencies
require "rails"
require "active_support/railtie"
require "action_dispatch/railtie"
require "action_controller/railtie"

class SingleFile < Rails::Application
  # Set up production configuration
  config.eager_load = true
  config.cache_classes = true

  # A key base is required for our app to boot
  config.secret_key_base = "pa34u13hsleuowi1aisejkez12u39201pluaep2ejlkwhkj"

  # Define a basic route
  routes.append do
    root to: lambda { |env|
      [200, { "Content-Type" => "text/plain" }, ["Hello world"]]  
    }
  end
end

SingleFile.initialize!
run Rails.application