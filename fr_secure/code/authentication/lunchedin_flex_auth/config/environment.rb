#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
RAILS_GEM_VERSION = '2.0.2' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')
require 'yaml'
Rails::Initializer.run do |config|
  
  config.action_controller.session = {
    :session_key => '_lunchedin_session',
    :secret      => 'cf9d327f2d16793b606c6689f76e90c3'
  }
  
  LDAP_CONF = YAML.load_file("#{RAILS_ROOT}/config/ldap.yml")
  
  AUTHENTICATION_MECHANISM = "ldap"
end