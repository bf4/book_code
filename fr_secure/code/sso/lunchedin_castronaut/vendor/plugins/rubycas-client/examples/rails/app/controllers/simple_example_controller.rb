#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
# This is the most basic, bare-bones example.
# For advanced usage see the AdvancedExampleController.
class SimpleExampleController < ApplicationController
  # This will force CAS authentication before the user
  # is allowed to access any action in this controller. 
  before_filter CASClient::Frameworks::Rails::Filter

  def index
    @username = session[:cas_user]
  end

  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end

end
