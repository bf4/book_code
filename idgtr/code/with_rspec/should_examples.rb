#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
describe 'RSpec' do
  it 'supports writing clear tests' do
    (2 + 2).should == 4
    1.should be < 2
    ['this', 'list'].should_not be_empty
    {:color => 'red'}.should have_key(:color)
  end
end