#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---

module Spec
  module Mocks
    module ArgumentMatchers

      class GreaterThanThreeMatcher
        def ==(actual)
          actual > 3
        end
      end

      def greater_than_3
        GreaterThanThreeMatcher.new
      end

      class GreaterThanMatcher

        def initialize(expected)
          @expected = expected
        end

        def description
          "a number greater than #{@expected}"
        end

        def ==(actual)
          actual > @expected
        end
      end

      def greater_than(floor)
        GreaterThanMatcher.new(floor)
      end
    end
  end
end


describe "GreaterThanMatcher" do
  
  before(:each) do
    @subject = mock('sugreaterbject')
    @subject.should_receive(:msg).with(greater_than_3)
  end
  
  it "should succeed when the arg is greater" do
    @subject.msg(4)
  end
  
  it "should fail when the arg is the same" do
    @subject.msg(3) 
  end

  it "should fail when the arg is smaller" do
    @subject.msg(2)
  end
end


describe "GreaterThanMatcher" do
  
  before(:each) do
    @subject = mock('subject')
    @subject.should_receive(:msg).with(greater_than(3))
  end
  
  it "should succeed when the arg is greater" do
    @subject.msg(4)
  end
  
  it "should fail when the arg is the same" do
    @subject.msg(3) 
  end

  it "should fail when the arg is smaller" do
    @subject.msg(2)
  end
end
