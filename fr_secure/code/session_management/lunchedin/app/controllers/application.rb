#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  
  protect_from_forgery # :secret => 'cf9d327f2d16793b606c6689f76e90c3'
  

  before_filter :check_authentication, :except => [ :logout ]
  
  
  before_filter :validate_session_expiry, :update_session_expiry  

  

  def check_authentication
    if session[:user_id]
      begin
        @authenticated_user = User.find(session[:user_id])
        return
      rescue
        reset_session
        redirect_to :controller => "session" and return
      end
    end
    redirect_to :controller => "session"
  end


  
  private

  def validate_session_expiry
    if session[:updated_at] &&
      (session[:updated_at] + 20.minutes) < Time.now
      reset_session
      raise RuntimeError.new("session expired")
    end
  end

  def update_session_expiry
    session[:updated_at] = Time.now
  end  
  
  
end
