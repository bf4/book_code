#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
class ApplicationController < ActionController::Base

  before_filter :set_preferred_view!
  before_filter :prepare_mobile_request!

  def set_preferred_view!
    if mobile_request?
      case params[:prefer_view]
      when 'standard'
        session[:preferred_view] = :standard
      when 'mobile'
        session[:preferred_view] = :mobile
      end
    end
  end

  def prepare_mobile_request!
    if mobile_request? && preferred_view == :mobile
      request.format = :mobile
    end
  end

  def preferred_view
    if mobile_request?
      session[:preferred_view] || :mobile
    else
      :standard
    end
  end
  helper_method :preferred_view

  def mobile_request?
    request.user_agent =~ /iP(?:one|ad|od)/
  end
  helper_method :mobile_request?
  
end
