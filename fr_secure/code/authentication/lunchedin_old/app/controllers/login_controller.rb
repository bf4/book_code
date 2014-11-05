#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class LoginController < ApplicationController
  
  skip_before_filter :check_authentication
  
  def index
    render :action => 'login'
  end
  
  
  def check_login
    user = params[:user]
    @user = User.find_by_user_name(user[:user_name]) 
    if(!@user.nil? && @user.password == Digest::SHA1.hexdigest("#{@user.salt}#{user[:password]}")) 
      session[:user_id] = @user.id
      redirect_to :controller => 'profile', :action => 'show', :id => @user.id
    else
      
      flash[:notice] = "the user #{params[:user][:user_name]}, "
      flash[:notice] << "was not found with the specified password"
      redirect_to :controller => 'login', :action => 'login'
      
    end
  end
  
  
end
