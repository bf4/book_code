#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'twitter'

describe "Twitter User" do
  describe "with a username" do
    before( :each ) do
      @user = User.new
      @user.twitter_username = 'cosmo'
    end
    it "provides the last five tweets from Twitter" do
      pending
      @user.last_five_tweets.should have(5).tweets
    end

    it "provides the last five tweets from Twitter" do
      pending
      tweets = [
      "These pretzels are making me thirsty",
      "It's like a sauna in here",
      "No bagel, no bagel, no bagel",
      "@jerry, it's L.A., nobody leaves",
      "Who's gonna turn down a Junior Mint?"
      ]

      @user.last_five_tweets.should be tweets
    end

    it "should extract 9 digit zip codes too" do
      @user.address_text = '1521 Fake St.\nFaketown, MO 12345-6789'
      @user.zip_code.should == '12345-6789' 
    end

    it "provides the last five tweets from Twitter" do
      tweets = %w(tweet1, tweet2, tweet3, tweet4, tweet5)

      mock_client = mock('client')
      mock_client.should_receive(:per_page).with(5).and_return(mock_client)
      mock_client.should_receive(:from).with('cosmo').and_return(tweets)
      Twitter::Search.should_receive(:new).and_return(mock_client)

      @user.last_five_tweets.should be tweets
    end
  end
  
  it "should allow addresses with no zip code" do
    user = User.new 
    user.address_text = 'P.O. BOX 7122 Chicago, IL'
    user.zip_code
  end
 
  it "should treat missing zip codes as nil" do
    user = User.new 
    user.address_text = 'P.O. BOX 7122 Chicago, IL'
    user.zip_code.should be_nil
  end
  
  it "should treat missing addresses like missing zip code" do
    user = User.new
    user.zip_code.should be_nil
  end
  
  it "uses the current locale to parse zip codes" do
    pending
    Locales.current = Locales::UNITED_KINGDOM
    user = User.new
    user.address_text = '51-55 Gresham Street, 6th Floor London, England EC2V 7HQ'
    user.zip_code.should == 'EC2V 7HQ' 
  end

  it "uses the current locale to parse zip codes" do
    Locales.should_receive(:current).and_return(Locales::UNITED_KINGDOM);
    user = User.new
    user.address_text = '51-55 Gresham Street, 6th Floor London, England EC2V 7HQ'
    user.zip_code.should == 'EC2V 7HQ' 
  end
  
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
