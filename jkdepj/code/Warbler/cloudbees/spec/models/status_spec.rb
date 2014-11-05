#---
# Excerpted from "Deploying with JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jkdepj for more book information.
#---
require 'spec_helper'

describe Status do
  context "#retweet" do
    it "turns tweet into status" do
      tweets = [
        mock_tweet("a", "joe", "123")
      ]

      s = Status.find_or_create_from(tweets)
      s.size.should == 1
      s[0].status_text.should == "a"
      s[0].creator.should == "joe"
      s[0].remote_id.should == "123"
    end
  end

  def mock_tweet(text, from_user, id_str)
    m = mock
    m.stub!(:created_at).and_return(Time.now)
    m.stub!(:text).and_return(text)
    m.stub!(:from_user).and_return(from_user)
    m.stub!(:id).and_return(id_str)
    m
  end
end
