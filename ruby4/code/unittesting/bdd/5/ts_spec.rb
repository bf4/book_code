#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
require_relative "tennis_scorer"

describe TennisScorer, "basic scoring" do

  let(:ts) { TennisScorer.new}

  it "should start with a score of 0-0" do
    ts.score.should == "0-0"
  end

  it "should be 15-0 if the server wins a point" do
    ts.give_point_to(:server)
    ts.score.should == "15-0"
  end

  it "should be 0-15 if the receiver wins a point" do
    ts.give_point_to(:receiver)
    ts.score.should == "0-15"
  end

  it "should be 15-15 after they both win a point" do
    ts.give_point_to(:receiver)
    ts.give_point_to(:server)
    ts.score.should == "15-15"
  end
end
