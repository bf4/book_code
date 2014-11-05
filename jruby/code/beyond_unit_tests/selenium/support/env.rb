#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'selenium'

$browser = Selenium::SeleniumDriver.new("localhost",
                                        4444,
                                        "*firefox",
                                        "http://www.yahoo.com",
                                        15000)

$browser.start

at_exit {$browser.stop}
