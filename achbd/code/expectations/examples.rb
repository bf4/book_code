#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
require 'rubygems'
require 'spec'
require 'test/unit'

class ExampleTest < Test::Unit::TestCase
  def test_assert_equal
    result = 5
assert_equal 5, result
  end
end

describe "Some examples" do
  specify do
result = 5
result.should equal(5)
result.should(equal(5))
  end
  
  specify do
    message = "will happen on Sunday, ..."
message.should match(/on Sunday/)
  end

  specify do
    team = Class.new do
      def players
        (1..11).inject([]) do |result, index|
          result << Object.new
        end
      end
    end.new
team.should have(11).players
  end

  def do_something_risky
    raise "sometimes risks pay off ... but not this time"
  end
  specify do
lambda { do_something_risky }.should raise_error(
  RuntimeError, "sometimes risks pay off ... but not this time"
)
  end
  
end

describe "Custom Expectation Examples" do
  def disqualify(entry); end
  specify do
    judge = Object.new
    participant = Object.new
judge.should disqualify(participant)
  end

  def notify_applicant(email, content); end
  specify do
registration = Object.new
registration.should notify_applicant("person@domain.com", /Dear Person/)
  end
  specify do
  end
  specify do
  end
end

describe "Sexy Predicates" do
  def do_something_with(array); end
  it "should turn you on" do
    array = []
do_something_with(array) unless array.empty?
array.empty?.should == true
array.should be_empty
  end
end

class User
  def in_role?(role)
    true
  end
end
describe "User/role example" do
  it "should be in role" do
    user = Class.new do
      def in_role?(role); true; end
    end.new
user.should be_in_role("admin")
  end
end