#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_authorization
  
  private
  def check_authorization
    unless current_user.can?(action_name, controller_name)
      redirect_to :back, 
                  :error => "You are not authorized to view the page you requested"
   end
end
