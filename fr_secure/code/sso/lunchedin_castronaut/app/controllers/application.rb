#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  
  protect_from_forgery # :secret => 'cf9d327f2d16793b606c6689f76e90c3'
  
  before_filter CASClient::Frameworks::Rails::Filter, :except => [ :logout ]
  before_filter :check_authentication, :except => [ :logout ]
    
  
  def check_authentication
    if session[:cas_user]
      @authenticated_user = User.find_by_username(session[:cas_user])
      if @authenticated_user
        session[:user_id] = @authenticated_user.id
        return true
      else
        redirect_to :controller => "users", :action => :new and return
      end
    end
  end
  
end
