#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'revisions/user3.3'

describe "Twitter User" do
  it "filters out users who aren't following it" do
    user = User.new
    user.followers = ['kentbeck'] 
    user.following_me(['jbrains', 'mfeathers', 'kentbent']).should == []
  end

  it "returns an empty list if no followers" do
    user = User.new
    user.following_me(['jbrains', 'mfeathers', 'kentbent']).should == []
  end

  it "returns all followers if no other users specified" do
    user = User.new
    user.followers = ['kentbeck'] 
    user.following_me().should == ['kentbeck']
  end
end
