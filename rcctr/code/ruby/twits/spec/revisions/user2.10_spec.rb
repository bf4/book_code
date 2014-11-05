#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'revisions/user2.9'

describe "Twitter User" do
  it "should extract 9 digit zip codes too" do
    user = User.new
    user.address_text = '1521 Fake St.\nFaketown, MO 12345-6789'
    user.zip_code.should == '12345-6789' 
  end
end
