#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'twitter'
require 'revisions/user2.8'

describe "Twitter User" do
  it "should allow addresses with no zip code" do
    user = User.new 
    user.address_text = 'P.O. BOX 7122 Chicago, IL'
    user.zip_code
  end
 
  it "should treat missing zip codes as nil" do
    user = User.new 
    user.address_text = 'P.O. BOX 7122 Chicago, IL'
    user.zip_code.should be nil
  end
end
