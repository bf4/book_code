#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'revisions/tweet_analyzer4.1'

describe TweetAnalyzer do
  it "finds the frequency of words in a user's tweets" do
    analyzer = TweetAnalyzer.new(mock_user = double("user"))
    histogram = analyzer.word_frequency()
  end
end
