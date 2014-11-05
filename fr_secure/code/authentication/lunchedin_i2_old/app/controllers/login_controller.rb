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

  def index
    render :action => 'login'
  end
  
  
  def check_login
    user = params[:user]
    if (@user = authenticate(user[:user_name], user[:password])) 
      # This particular code is expecting the authenticate method to return a User object.
      # In the case of another authentication method like LDAP, we will still return the @user - Our application is still 
      # Responsible for maintaining a profile of the user.
      session[:user_id] = @user.id
      redirect_to :controller => 'profile', :action => 'show', :id => @user.id
    else
      
      flash[:notice] = "the user #{params[:user][:user_name]}, "
      flash[:notice] << "was not found with the specified password"
      redirect_to :controller => 'login', :action => 'login'
      
    end
  end
  
  
end
