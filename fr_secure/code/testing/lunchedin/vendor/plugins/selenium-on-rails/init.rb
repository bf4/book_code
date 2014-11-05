#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require 'selenium_on_rails_config'
envs = SeleniumOnRailsConfig.get :environments

if envs.include? RAILS_ENV
  #initialize the plugin
  $LOAD_PATH << File.dirname(__FILE__) + "/lib/controllers"
  require 'selenium_controller'
  require File.dirname(__FILE__) + '/routes'

  SeleniumController.prepend_view_path File.expand_path(File.dirname(__FILE__) + '/lib/views')
else
  #erase all traces
  $LOAD_PATH.delete lib_path
end

