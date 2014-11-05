#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class PagesController < ApplicationController
  http_basic_authenticate_with :name => "recipes", 
                               :password => "secret",
                               :realm => "Beta"
  def index
  end

  def help
  end

  def about
  end

end
