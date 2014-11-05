#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class ApplicationController < ActionController::Base
  
  session :session_key => '_lunchedin_session_id'
  before_filter :check_authentication, :except => [ :logout ]
  layout 'main'  
  
  def check_authentication
    if session[:user_id]
      begin
        @user = User.find(session[:user_id]) and return
      rescue
        reset_session
      end
    end
    redirect_to :controller => "login", :action => "login" and return
  end
  
  def logout
    reset_session
    redirect_to :controller => "login", :action => "login"
  end  
end
