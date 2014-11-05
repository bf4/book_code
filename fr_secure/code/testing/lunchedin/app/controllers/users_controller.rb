#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---

class UsersController < ApplicationController
  ssl_required :create unless RAILS_ENV['development']
  ssl_allowed :new, :show
  

  skip_before_filter :check_authentication, :only => [:index, :new, :create]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  
  
  def create
    @user = User.new(params[:user])  
    respond_to do |format|
      if @user.save  
        flash[:notice] = 'your account was successfully created.'
        session[:user_id] = @user.id
        format.html { redirect_to(@user) }
      else
        format.html { render :action => 'new' }
      end    
    end
  end
  

end
