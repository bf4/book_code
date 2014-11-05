#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class BankAccountController < ApplicationController
  before_filter :update_activity_time, :except => :session_expiry
  def update_activity_time
    session[:expires_at] = 10.minutes.from_now
  end
  def session_expiry
    @time_left = (session[:expires_at] - Time.now).to_i rescue 0
    unless @time_left > 0
      reset_session
      render '/signin/redirect'
    end
  end         
end