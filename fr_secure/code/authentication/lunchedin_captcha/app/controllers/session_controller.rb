#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class SessionController < ApplicationController

  skip_before_filter :check_authentication
  
  def index
    render :action => 'login'
  end
  
  
  def check_login
    username, password = params[:user][:username], params[:user][:password]
    if @authenticated_user = User.find_and_authenticate(username, password) 
      session[:user_id] = @authenticated_user.id
      redirect_to user_path(@authenticated_user)
    else
      
      flash[:notice] = "the user #{params[:user][:username]}, "
      flash[:notice] << "was not found with the specified password"
      redirect_to :controller => 'session', :action => 'login'
      
    end
  end
  
  
  def logout
    reset_session
  end
end
