#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'user'

describe "Twitter User" do
  it "should treat missing addresses like missing zip code" do
    user = User.new
    user.zip_code.should == nil
  end

  it "filters out users who aren't following it" do
    user = User.new
    user.followers = ['kentbeck'] 
    user.following_me(['jbrains', 'mfeathers', 'kentbent']).should == []
  end

  describe "with a username" do
    before( :each ) do
      @user = User.new
      @user.twitter_username = 'logosity'
    end

    it "provides the last five tweets from Twitter" do
      tweets = [
        {:text => 'tweet1'}, 
        {:text => 'tweet2'}, 
        {:text => 'tweet3'}, 
        {:text => 'tweet4'}, 
        {:text => 'tweet5'}
      ]

      mock_client = mock('client')
      mock_client.should_receive(:per_page).with(5).and_return(mock_client)
      mock_client.should_receive(:from).with('logosity').and_return(tweets)
      Twitter::Search.should_receive(:new).and_return(mock_client)

      @user.last_five_tweets.should == %w{tweet1 tweet2 tweet3 tweet4 tweet5}
    end
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
