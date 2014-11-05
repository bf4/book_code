#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
describe Stack do
  context "when empty" do
    before(:each) do
      @stack = Stack.new
    end
  end

  context "when almost empty (with one element)" do
    before(:each) do
      @stack = Stack.new
      @stack.push 1
    end
  end

  context "when almost full (with one element less than capacity)" do
    before(:each) do
      @stack = Stack.new
      (1..9).each { |n| @stack.push n }
    end
  end

  context "when full" do
    before(:each) do
      @stack = Stack.new
      (1..10).each { |n| @stack.push n }
    end
  end
end
