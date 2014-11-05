#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class LoginController < ApplicationController

  
  def verify
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      redirect_to :action => 'success'
    else
      redirect_to :action => 'failure'
    end    
  end
  

  def success
  end

  def failure
  end
end
