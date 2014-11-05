#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class AccountsController < ApplicationController
  
  def login
    case request.method
    when :post 
      begin 
        user = User.authenticate(@params[:email], @params[:password])
        session[:user] = user.id
        session[:locale] = user.locale
        go_to = session[:destination]
        session[:destination] = nil
        redirect_to (go_to || home_url) unless performed?
      rescue User::InvalidLoginException => e
        flash[:notice] = e.message
        redirect_to login_url unless performed?
      end
    when :get
    end
  end

  def logout
    @session[:user] = nil
    redirect_to home_url
  end  
  
  def change_locale
    session[:locale] = params[:locale] unless params[:locale].blank?
    redirect_to :back
  end  
  
end
