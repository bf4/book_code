#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class FeedController < ApplicationController
  before_filter :authenticate_access_key, :only => [:inbox]
  def authenticate_access_key
    inbox = Inbox.find_by_access_key(params[:access_key])  
    if inbox.blank? || inbox.id != params[:id].to_i 
      raise "Unauthorized"
    end
  end
  def inbox
    @inbox = Inbox.find(params[:id])
  end
end
