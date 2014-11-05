#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'rubygems'
require 'selenium'

browser = Selenium::SeleniumDriver.new \
  'localhost', 4444, '*chrome', 'http://www.pragprog.com', 10000

browser.start

browser.open 'http://www.pragprog.com/community'
browser.click '//div[text()="Dojo Foundation"]/following-sibling::ul/li/a'
browser.wait_for_page_to_load 5000
