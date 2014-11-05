#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'helper'

describe "disable-pry" do
  before do
    @t = pry_tester
  end

  after do
    ENV.delete 'DISABLE_PRY'
  end

  it 'should quit the current session' do
    lambda{
      @t.process_command 'disable-pry'
    }.should.throw(:breakout)
  end

  it "should set DISABLE_PRY" do
    ENV['DISABLE_PRY'].should == nil
    lambda{
      @t.process_command 'disable-pry'
    }.should.throw(:breakout)
    ENV['DISABLE_PRY'].should == 'true'
  end
end
