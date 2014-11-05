#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'active_support/all'
require 'active_support/test_case'
require 'action_controller'

# work around the at_exit hook in test/unit, which kills IRB
Test::Unit.run = true if Test::Unit.respond_to?(:run=)

# reference the global "app" instance, created on demand. To recreate the
# instance, pass a non-false value as the parameter.
def app(create=false)
  @app_integration_instance = nil if create
  @app_integration_instance ||= new_session do |sess|
    sess.host! "www.example.com"
  end
end

# create a new session. If a block is given, the new session will be yielded
# to the block before being returned.
def new_session
  app = Rails.application
  session = ActionDispatch::Integration::Session.new(app)
  yield session if block_given?
  session
end

# reloads the environment
def reload!(print=true)
  puts "Reloading..." if print
  ActionDispatch::Reloader.cleanup!
  ActionDispatch::Reloader.prepare!
  true
end
