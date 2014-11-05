#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
class AuthenticatedController < ApplicationController
  before_filter :authenticate

  private

  def authenticate
    authenticate_or_request_with_http_basic do |user_name, password|
      Administrator.find_by_username_and_password(user_name, password)
    end
  end
end
