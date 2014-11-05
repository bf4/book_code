#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class ApplicationController < ActionController::Base
  def user2utc(time)
    current_user.tz.unadjust(time)
  end
  
  def utc2user(time)
    current_user.tz.adjust(time)
  end
  
  def current_user
    User.find(session[:user])
  end
end
