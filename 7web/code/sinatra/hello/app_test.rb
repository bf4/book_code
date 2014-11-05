#---
# Excerpted from "Seven Web Frameworks in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
#---
require_relative "app"
require "rspec"
require "rack/test"

describe "Hello application" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "says hello" do
    get "/hello"
    last_response.should be_ok
    last_response.body.should == "Hello, Sinatra"
  end
end
