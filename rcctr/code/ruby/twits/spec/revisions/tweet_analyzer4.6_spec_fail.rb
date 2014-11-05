#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'revisions/tweet_analyzer4.5'

describe TweetAnalyzer do
  before( :each ) do
    @expected_tweets = []
    @mock_user = double('mock user')
    @mock_user.stub(:recent_tweets).and_return @expected_tweets
    @mock_user.stub(:username).and_return("bill")
    @analyzer = TweetAnalyzer.new(@mock_user)
  end

  it "finds the frequency of words in a user's tweets" do
    @expected_tweets << "one"
    histogram = @analyzer.word_frequency()
    histogram["one"].should == 1
  end

  it "asks the users for recent tweets" do
    @expected_tweets << "one two" << "two"
    histogram = @analyzer.word_frequency()
    histogram["two"].should == 2
  end

  it "can find word frequency for a number of tweets" do
    @expected_tweets << "one" << "two two" << "three three three"
    histogram = @analyzer.word_frequency(3)
    histogram["one"] = 1
    histogram["two"] = 2
    histogram["three"] = 3
  end
end
