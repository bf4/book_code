#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
require 'nondeterminism_example'

describe "Nondeterminism example" do
  
  before(:each) do
    @die = mock('die')
    @target = NondeterminismExample.new(@die)
  end
  
  it "should roll the die" do
    @die.should_receive(:roll).once.and_return(1)
    @target.move
  end
  
  it "should move according to the die roll" do
    @die.stub(:roll).and_return(1)
    @target.move
    @target.position.should == 1
  end

  it "should accumulate moves" do
    @die.stub(:roll).and_return(1, 2, 3, 4)
    @target.move
    @target.move
    @target.move
    @target.move
    @target.position.should == 10
  end

end