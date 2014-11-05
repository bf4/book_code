#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'selenium'
require 'chronic'

class PartyWorld
  @@browser = Selenium::SeleniumDriver.new \
    'localhost', 4444, '*firefox', 'http://localhost:3000', 10000
  @@browser.start
  at_exit {@@browser.stop}
  def browser; @@browser end
end

World do
  PartyWorld.new
end
