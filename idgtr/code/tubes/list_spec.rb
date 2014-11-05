#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'joke_list'

describe JokeList do
  before do
    @list = JokeList.new
  end

  after do
    @list.close
  end

  it 'lets me drag an item to the end' do
    @list.order('doctor').should == 2
    @list.move 2, 5
    @list.order('doctor').should == 5
  end
  
  it 'lets me drag multiple items to sort' do
    original = @list.items

    original.length.downto(1) do |last_pos|
      subset = @list.items[0..last_pos - 1]
      max_pos = subset.index(subset.max) + 1
      @list.move max_pos, last_pos
    end

    @list.items.should == original.sort
  end
end
