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
    if @user = User.find(:first, :conditions =>         
        "username = '#{params[:user][:username]}' " +  
        "AND password = '#{params[:user][:password]}'") 
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      
      flash[:notice] = "the user #{params[:user][:username]}, "
      flash[:notice] << "was not found with the specified password"
      redirect_to '/login'
      
    end
  end
  

  def logout
    reset_session
  end
end
