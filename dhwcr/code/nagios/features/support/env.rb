#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
require 'time'
require 'cgi'
require 'webrat'
require 'nokogiri'

Webrat.configure do |config|
  config.mode = :mechanize
end
World Webrat::Methods
