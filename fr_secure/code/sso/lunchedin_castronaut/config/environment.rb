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

Rails::Initializer.run do |config|
  config.action_controller.session = {
    :session_key => '_lunchedin_session',
    :secret      => '2b6d57c18f8884b65d248d72bf97e0f62e3eaa5ad3ba9eb6fef402109'+
     '386ad0468758d2a3f19bb8f707e6a387531dfe344c9e99f699a8735f661a536f054d0de'
  }
end

# BEGIN_HIGHLIGHT
CASClient::Frameworks::Rails::Filter.configure(
  :cas_base_url => "http://localhost:4567/",
  :login_url     => "http://localhost:4567/login",
  :logout_url    => "http://localhost:4567/logout"
)
