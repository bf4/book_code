#---
# Excerpted from "Deploying with JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jkdepj for more book information.
#---
require 'spec_helper'

describe Analytics do
  context "#calc_positivity_followers_r" do
    it "returns 1" do
      statuses = [
          mock_status(1,1),
          mock_status(2,2),
          mock_status(3,3),
          mock_status(4,4),
          mock_status(5,5)
      ]
      r = Analytics.calc_positivity_followers_r(statuses)
      r.should == 1
    end

    it "returns 0" do
      statuses = [
          mock_status(1,3),
          mock_status(2,3),
          mock_status(3,3),
          mock_status(4,3),
          mock_status(5,3)
      ]
      r = Analytics.calc_positivity_followers_r(statuses)
      r.should == 0
    end

    it "returns -1" do
      statuses = [
          mock_status(1,5),
          mock_status(2,4),
          mock_status(3,3),
          mock_status(4,2),
          mock_status(5,1)
      ]
      r = Analytics.calc_positivity_followers_r(statuses)
      r.should == -1
    end
  end

  context "#calc_positivity_stdv" do
    it "returns 0" do
      statuses = [
          mock_status(1,1),
          mock_status(1,2),
          mock_status(1,3),
          mock_status(1,4),
          mock_status(1,5)
      ]
      r = Analytics.calc_positivity_stdv(statuses)
      r.should == 0
    end
  end

  def mock_status(positivity_score, followers_count)
    s = mock(:status)
    s.stub!(:positivity_score).and_return(positivity_score)
    s.stub!(:followers_count).and_return(followers_count)
    s
  end
end
