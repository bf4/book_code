#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require File.dirname(__FILE__) + '/../spec_helper'

describe "LaTeX" do
  examples_from_yaml do |doc|
    RedCloth.new(doc['in']).to_latex
  end
  
  it "should not raise an error when orphaned parentheses in a link are followed by punctuation and words in LaTeX" do
    lambda { 
      RedCloth.new(%Q{Test "(read this":http://test.host), ok}).to_latex
    }.should_not raise_error
  end
end