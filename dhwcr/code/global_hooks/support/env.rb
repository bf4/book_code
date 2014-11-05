#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
=begin
require 'selenium-webdriver'

$browser = Selenium::WebDriver.for :firefox
at_exit { $browser.quit }
=end

require 'selenium-webdriver'

module HasBrowser
  @@browser = Selenium::WebDriver.for :firefox
  at_exit { @@browser.quit }

  def browser
    @@browser
  end

end

World(HasBrowser)
# ... and I feel fine ...
