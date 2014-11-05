#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
require 'capybara/dsl'

Capybara.run_server = false
Capybara.default_driver = :selenium
Capybara.app_host = 'http://www.google.com'

class WebRobot
  include Capybara::DSL

  def go
    visit '/'
    # ... etc

    puts('press any key to finish')
    gets
  end
end

WebRobot.new.go
