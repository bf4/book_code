#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'google_search_service'

class SearchController < ApplicationController
  wsdl_service_name 'GoogleSearch'
  web_service_dispatching_mode :delegated
  web_service :beta3, GoogleSearchService.new
end
