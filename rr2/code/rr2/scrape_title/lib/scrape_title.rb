#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'httparty'
class ScrapeTitle
  include HTTParty
  def initialize(url)
    @url = url
  end
  
  def scrape
    html_content = ScrapeTitle.get(@url)
    html_content.match(%r{<title>(.*)</title>}m).captures.first
  end
end
