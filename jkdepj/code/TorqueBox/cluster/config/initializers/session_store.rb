#---
# Excerpted from "Deploying with JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jkdepj for more book information.
#---
# Configure the TorqueBox Servlet-based session store.
# Provides for server-based, in-memory, cluster-compatible sessions
#{app_const}.config.session_store :torquebox_store
if ENV['TORQUEBOX_APP_NAME']
  Twitalytics::Application.config.session_store :torquebox_store
else
  Twitalytics::Application.config.session_store :cookie_store, :key => '_CHANGEME_session'
end