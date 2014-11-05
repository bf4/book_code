#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
class Stack; end

describe Stack do
  context "when empty" do
    it "should be empty"
    it "should not be full"
    it "should accept a push"
    it "should raise an error on pop"
    it "should raise an error on peek"
  end

  context "when almost empty (with one element)" do
    it "should not be empty"
    it "should not be full"
    it "should accept a push"
    it "should return top element on pop"
    it "should return top element on pop"
    it "should raise an error on peek"
  end

  context "when almost full (with one element less than capacity)" do
    it "should be empty"
    it "should not be full"
    it "should not be empty after push"
    it "should raise an error on pop"
    it "should raise an error on peek"
  end

  context "when full" do
    it "should be empty"
    it "should not be full"
    it "should not be empty after push"
    it "should raise an error on pop"
    it "should raise an error on peek"
  end
end
