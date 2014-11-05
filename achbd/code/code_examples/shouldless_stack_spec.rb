#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
require File.join(File.dirname(__FILE__), "/stack.rb")

describe Stack do
  before(:each) do
    @stack = Stack.new
    @stack.push :item
  end

  describe "#peek" do
    it "returns the top element" do
      @stack.peek.should == :item
    end
    
    it "does not remove the top element" do
      @stack.peek
      @stack.size.should == 1
    end
  end
  
  describe "#pop" do
    it "returns the top element" do
      @stack.pop.should == :item
    end

    it "removes the top element" do
      @stack.pop
      @stack.size.should == 0
    end
  end
end
