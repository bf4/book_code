#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
class ApplicationController < ActionController::Base

  before_filter :prepare_mobile_request!

  def prepare_mobile_request!
    if mobile_request?
      request.format = :mobile
    end
  end

  def mobile_request?
    request.user_agent =~ /iP(?:hone|ad|od)/
  end
  helper_method :mobile_request?

end
