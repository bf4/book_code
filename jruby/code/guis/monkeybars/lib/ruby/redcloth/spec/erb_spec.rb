#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require File.dirname(__FILE__) + '/spec_helper'

describe "ERB helper" do
  it "should add a textile tag to ERB" do
    template = %{<%=t "This new ERB tag makes is so _easy_ to use *RedCloth*" %>}
    expected = %{<p>This new <span class="caps">ERB</span> tag makes is so <em>easy</em> to use <strong>RedCloth</strong></p>}
    
    ERB.new(template).result.should == expected
  end
end