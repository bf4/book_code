#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'helper'

describe "gem-list" do
  # fixing bug for 1.8 compat
  it 'should not raise when invoked' do
    proc {
      pry_eval(self, 'gem-list')
    }.should.not.raise
  end

  it 'should work arglessly' do
    list = pry_eval('gem-list')
    list.should =~ /slop \(/
    list.should =~ /bacon \(/
  end

  it 'should find arg' do
    prylist = pry_eval('gem-list slop')
    prylist.should =~ /slop \(/
    prylist.should.not =~ /bacon/
  end

  it 'should return non-results as silence' do
    pry_eval('gem-list aoeuoueouaou').should.empty?
  end
end
