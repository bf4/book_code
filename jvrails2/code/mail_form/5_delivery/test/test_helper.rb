#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

require "capybara"
require "capybara/rails"

# Define a bare test case to use with Capybara
class ActiveSupport::IntegrationCase < ActiveSupport::TestCase
  include Capybara::DSL
  include Rails.application.routes.url_helpers
end
