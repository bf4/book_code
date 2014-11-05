#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class ProfileController < ApplicationController
  
  skip_before_filter :check_authentication, :only => [:index, :new, :create]  
  skip_before_filter :authorization_filter, :only => [:new, :index, :create]
  
  def index
    new
    render :action => 'new'
  end
  
  def new
    @hide_tabs = true
    @user = User.new
  end
  
  
  def create
    @hide_tabs = true    
    @user = User.new(params[:user])  
    if @user.save  
      flash[:notice] = 'your account was successfully created.'
      session[:user_id] = @user.id
      redirect_to :action => 'my_profile', :id => @user
    else
      render :action => 'new'
    end    
  end
  
  
  roles :user, :admin
  def my_profile
    @user = User.find(session[:user_id])
    render :action => 'show'
  end
end
