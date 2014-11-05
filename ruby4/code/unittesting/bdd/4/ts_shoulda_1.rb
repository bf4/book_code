#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
require 'test/unit'
require 'shoulda'
require_relative 'tennis_scorer.rb'

class TennisScorerTest < Test::Unit::TestCase
  def assert_score(target)
    assert_equal(target, @ts.score)
  end
  context "Tennis scores" do
    setup do
      @ts = TennisScorer.new
    end
    should "start with a score of 0-0" do
      assert_score("0-0")
    end
    context "where the server wins a point" do 
      setup do
        @ts.give_point_to(:server)
      end
      should "be 15-0" do
        assert_score("15-0")
      end
      context "and the oponent wins a point" do
        setup do
          @ts.give_point_to(:receiver)
        end
        should "be 15-15" do
          assert_score("15-15") 
        end
      end
    end
    should "be 0-15 if the receiver wins a point" do
      @ts.give_point_to(:receiver)
      assert_score("0-15")
    end
  end
end
