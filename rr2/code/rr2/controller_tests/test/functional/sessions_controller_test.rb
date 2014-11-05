#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test_helper'
class U
  def id
    123
  end
end
def users(*)
  U.new
end
class SessionsControllerTest < ActionController::TestCase
  test "can authenticate with user and password" do
    post :create, :username => "kurt", :password => "m0th3r-n1ght"
    assert_equal users(:kurt).id, session[:user_id]
  end
end
