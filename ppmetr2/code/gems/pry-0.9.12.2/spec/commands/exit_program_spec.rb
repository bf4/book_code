#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'helper'

describe "exit-program" do
  it 'should raise SystemExit' do
    proc {
      pry_eval('exit-program')
    }.should.raise SystemExit
  end

  it 'should exit the program with the provided value' do
    begin
      pry_eval 'exit-program 66'
    rescue SystemExit => e
      e.status.should == 66
    else
      raise "Failed to raise SystemExit"
    end
  end
end
