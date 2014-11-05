#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'java'

java_import java.util.HashMap

describe "An empty", HashMap do 
  before :each do 
    @map = HashMap.new
  end
  
  it "should be empty" do 
    @map.should be_empty
  end
  
  it "should have size zero" do 
    @map.size.should == 0
  end
  
  it "should allow elements to be added"
end
