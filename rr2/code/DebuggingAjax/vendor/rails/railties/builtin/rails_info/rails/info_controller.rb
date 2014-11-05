#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Rails::InfoController < ActionController::Base
  def properties
    if local_request?
      render :inline => Rails::Info.to_html
    else
      render :text => '<p>For security purposes, this information is only available to local requests.</p>', :status => 500
    end
  end
end
