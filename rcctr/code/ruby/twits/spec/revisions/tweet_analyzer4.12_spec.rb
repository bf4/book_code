#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'tweet_analyzer'

describe TweetAnalyzer do
  before( :each ) do
    @queried_tweets = []
    @mock_user = double('mock user')
    @mock_user.stub(:recent_tweets).and_return @queried_tweets
    @mock_user.stub(:username).and_return("bill")
    @analyzer = TweetAnalyzer.new(@mock_user)

    # Mocking out MongoDB for this test, but
    # the intent of this test is to show
    # interaction with Mongo, so don't 
    # include this setup
    Mongo::Connection.stub_chain(:new, :db, :collection).and_return(mock_collection = double('collection'))
    mock_collection.stub(:count).and_return(20)
    cached_tweets = (0..19).map {|i| {'tweet' => "cached #{i}"}}
    mock_collection.stub(:find).and_return(cached_tweets)
  end

  it "finds the frequency of words in a user's tweets" do
    @queried_tweets << "one"
    histogram = @analyzer.word_frequency(3)
    histogram["one"].should == 1
  end

  it "asks the users for recent tweets" do
    @queried_tweets << "one two" << "two"
    histogram = @analyzer.word_frequency()
    histogram["two"].should == 2
  end

  it "can find word frequency for a number of tweets" do
    @queried_tweets << "one" << "two two" << "three three three"
    histogram = @analyzer.word_frequency(3)
    histogram["one"] = 1
    histogram["two"] = 2
    histogram["three"] = 3
  end

  it "caches tweets in Twitter to prevent multiple requests" do
    20.times { |i| @queried_tweets << "remote #{i}" }

    histogram = @analyzer.word_frequency(40) 
    histogram["remote"].should == 20
    histogram["cached"].should == 20
  end
end
