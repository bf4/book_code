#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class ApplicationController < ActionController::Base

  layout 'default'

  before_filter :set_locale
  
  #########
  protected
  #########

  def authenticate
    return true if controller_name =~ /accounts$/
    unless session[:user] 
      session[:destination] = request.request_uri
      redirect_to login_url
      false
    end
  end

  def set_locale
    Locale.set session[:locale] unless session[:locale].blank?
    true
  end
  
  def current_user(force_reload=false)
    if force_reload
      @current_user = User.find(session[:user]) rescue nil
    else
      @current_user ||= User.find(session[:user]) rescue nil
    end
  end
  helper_method :current_user
  
  def logged_in?
    current_user
  end
  helper_method :logged_in?
  
end