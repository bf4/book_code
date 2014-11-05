#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class LoginController < ApplicationController
  include DatabaseAuthenticationControl
  skip_before_filter :check_authentication
  skip_before_filter :authorization_filter
  
  def index
    render :action => 'login'
  end
  
  def check_login
    logger.debug ">>> #{self}#check_login called"
    user = params[:user]
    if (@user = authenticate(user[:user_name], user[:password])) 
      logger.debug "Successfully authenticated #{user[:user_name]}"
      session[:user_id] = @user.id
      redirect_to :controller => 'profile', :action => 'my_profile', :id => @user.id
      return true
    else
      flash[:notice] = "the user #{params[:user][:user_name]}, "
      flash[:notice] << "was not found with the specified password"
      redirect_to :controller => 'login', :action => 'login' and return false
    end
  end  
end
