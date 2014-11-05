#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
# Controller for handling the login, logout process for "users" of our
# little server.  Users have no password.  This is just an example.

require 'openid'

class LoginController < ApplicationController

  layout 'server'

  def base_url
    url_for(:controller => 'login', :action => nil, :only_path => false)
  end

  def index
    response.headers['X-XRDS-Location'] = url_for(:controller => "server",
                                                  :action => "idp_xrds",
                                                  :only_path => false)
    @base_url = base_url
    # just show the login page
  end

  def submit
    user = params[:username]

    # if we get a user, log them in by putting their username in
    # the session hash.
    unless user.nil?
      session[:username] = user unless user.nil?
      session[:approvals] = []
      flash[:notice] = "Your OpenID URL is <b>#{base_url}user/#{user}</b><br/><br/>Proceed to step 2 below."
    else
      flash[:error] = "Sorry, couldn't log you in. Try again."
    end
    
    redirect_to :action => 'index'
  end

  def logout
    # delete the username from the session hash
    session[:username] = nil
    session[:approvals] = nil
    redirect_to :action => 'index'
  end

end
