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
  include SimpleCaptcha::ControllerHelpers
  helper :all # include all helpers, all the time
  protect_from_forgery # :secret => 'cf9d327f2d16793b606c6689f76e90c3'

  before_filter :check_authentication, :except => [ :logout ]

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
  
end
