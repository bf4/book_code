# This file is used by Rack-based servers to start the application.

# START:stomp
require 'torquebox-stomp'
use TorqueBox::Stomp::StompJavascriptClientProvider
# END:stomp

require ::File.expand_path('../config/environment',  __FILE__)
run Twitalytics::Application
