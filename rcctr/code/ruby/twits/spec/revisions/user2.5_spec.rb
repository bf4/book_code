#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'revisions/user2.5'

describe "Twitter User" do
  describe "with a username" do
    before( :each ) do
      @user = User.new
      @user.twitter_username = 'logosity'
    end

    it "provides the last five tweets from Twitter" do
      @user.last_five_tweets.should have(5).tweets
    end
  end
end
