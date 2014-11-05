#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TweetAnalyzer do
  def mock_collection
    Mongo::Connection.should_receive(:new).
      and_return(mock_connection = double("connection"))
    mock_connection.should_receive(:db).with("twitterCache").
      and_return(mock_db = double("db"))
    mock_db.should_receive(:collection).with("bill").
      and_return(mock_collection = double("collection"))
    mock_collection
  end

  before( :each ) do
    @expected_tweets = []
    @mock_user.stub(:recent_tweets).and_return @expected_tweets
    @mock_user.stub(:username).and_return("bill")
    @analyzer = TweetAnalyzer.new(@mock_user)
  end

  describe "with no cached tweets" do

    before( :each ) do
      mock_collection.stub(:find).and_return([])
    end


=begin
  it "finds the frequency of words in a user's tweets" do
    analyzer = TweetAnalyzer.new(mock_user = double("user"))
    histogram = analyzer.word_frequency()
    histogram["one"].should == 1
  end
=end

    it "asks the users for recent tweets" do
      pending
      analyzer = TweetAnalyzer.new(mock_user = double("user"))
      expected_tweets = ["one too", "too"]
      mock_user.should_receive(:recent_tweets).and_return expected_tweets
      histogram = analyzer.word_frequency()
      histogram["too"].should == 2
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
      @expected_tweets << "one"
      histogram = @analyzer.word_frequency(3)
      histogram["one"] = 1
      histogram["two"] = 2
      histogram["three"] = 3
    end

=begin
    it "caches tweets in Twitter to prevent multiple requests" do
      cached_tweets = []
      20.times { |i| @expected_tweets << "remote #{i}" }
      20.times { |i| cached_tweets << "cached #{i}" }

      coll = Mongo::Connection.new.db("twitterCache").collection("bill")
      cached_tweets.each_with_index { |tweet, index|
        coll.insert({:timestamp => index, :tweet => tweet})
      }
      coll.count().should == 20
      actual_tweets = coll.find().collect{|doc| doc['tweet']}
      actual_tweets.should == cached_tweets

      histogram = @analyzer.word_frequency(40)
      histogram["remote"].should == 20
      histogram["cached"].should == 20
    end
=end

  end


  it "caches tweets in Twitter to prevent multiple requests" do
    pending
    cached_tweets = []
    20.times { |i| @expected_tweets << "remote #{i}" }
    20.times { |i| cached_tweets << "cached #{i}" }

    histogram = @analyzer.word_frequency(40)
    histogram["remote"].should == 20
    histogram["cached"].should == 20
  end

  it "caches tweets in Twitter to prevent multiple requests" do
    Mongo::Connection.should_receive(:new).
      and_return(mock_connection = double("connection"))
    mock_connection.should_receive(:db).with("twitterCache").
      and_return(mock_db = double("db"))
    mock_db.should_receive(:collection).with("bill").
      and_return(mock_collection = double("collection"))

    20.times { |i| @expected_tweets << "remote #{i}" }
    tweet_docs = (0..19).collect { |i| {'tweet' => "cached #{i}"} }
    mock_collection.should_receive(:find).and_return tweet_docs

    histogram = @analyzer.word_frequency(40)
    histogram["remote"].should == 20
    histogram["cached"].should == 20
  end

  it "caches tweets in Twitter to prevent multiple requests" do
    20.times { |i| @expected_tweets << "remote #{i}" }
    tweet_docs = (0..19).collect { |i| {'tweet' => "cached #{i}"} }
    mock_collection.should_receive(:find).and_return tweet_docs

    histogram = @analyzer.word_frequency(40)
    histogram["remote"].should == 20
    histogram["cached"].should == 20
  end

end
