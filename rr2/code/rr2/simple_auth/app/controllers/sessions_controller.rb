#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class SessionsController < ApplicationController
  def new
  end
  def create
    session[:user_id] = User.authenticate(params[:username], params[:password]).id
    flash[:notice] = "Welcome back!"
    redirect_to :action => session[:intended_action],
                :controller => session[:intended_controller]
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Come back soon!"
  end
end
