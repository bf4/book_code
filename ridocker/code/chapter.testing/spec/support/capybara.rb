#---
# Excerpted from "Docker for Rails Developers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/ridocker for more book information.
#---
Capybara.register_driver :chrome_in_container do |app|    
  Capybara::Selenium::Driver.new app,                     
    browser: :remote,                                     
    url: "http://chrome:4444/wd/hub",                     
    desired_capabilities: :chrome                         
end                                                       

Capybara.javascript_driver = :chrome_in_container         
Capybara.app_host = "http://web:3000"                     
