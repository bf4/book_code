#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
require 'httparty'

class ApiWorld
  def take_square_root(number)
    response = HTTParty.get "http://localhost:4567/api/square_root/#{number}"
    @result = response.body.to_f
  end

  def square_root_result
    @result
  end
  
  def close
  end
end

After { close }

require 'selenium-webdriver'

class WebWorld
  def initialize
    @browser = Selenium::WebDriver.for :firefox
  end

  def take_square_root(number)
    @browser.navigate.to "http://localhost:4567"
    @browser.find_element(:name => 'number').send_keys number.to_s
    @browser.find_element(:name => 'submit').click
  end

  def square_root_result
    @browser.find_element(:id => 'result').text.to_f
  end

  def close
    @browser.quit
  end
end

if ENV['USE_GUI']
  World { WebWorld.new }
else
  World { ApiWorld.new }
end
