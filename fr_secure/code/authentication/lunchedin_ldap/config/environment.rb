#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
RAILS_GEM_VERSION = '2.2.2' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')
require 'yaml'
Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  
  LDAP_CONF = YAML.load_file("#{RAILS_ROOT}/config/ldap.yml")
  
  AUTHENTICATION_MECHANISM = "ldap"

end
