#---
# Excerpted from "Deploying Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cbdepra for more book information.
#---
require 'cap_gun'

set :cap_gun_action_mailer_config, {
  :address => "smtp.gmail.com",
  :port => 587,
  :user_name => "[YOUR_USERNAME]@gmail.com",
  :password => "[YOUR_PASSWORD]",
  :authentication => :plain 
}

set :cap_gun_email_envelope, { 
  :from => "deploy@massiveapp.com",
  :recipients => %w{me@massiveapp.com coworker@massiveapp.com},
  :prefix => "massiveapp deployed: "
}

after "deploy:restart", "cap_gun:email"

