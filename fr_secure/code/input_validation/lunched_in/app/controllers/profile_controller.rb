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
    render :action => 'show'
  end
  
  
  def edit_my_profile
    render :action => 'edit'
  end
  
  def save_my_profile
    if @user.update_attributes(params[:user])
      flash[:notice] = 'account successfully updated'
      redirect_to :action => 'my_profile', :id => @user
    else
      render :action => 'edit'
    end
  end
  
end
