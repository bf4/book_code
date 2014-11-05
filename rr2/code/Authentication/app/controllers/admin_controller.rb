#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class AdminController < ApplicationController
  before_filter :check_authentication

  def check_authentication
    unless session[:user]
      session[:intended_action] = action_name
      session[:intended_controller] = controller_name      
      redirect_to :action => "signin"
    end
  end
end
