#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'pp'

RSpec.describe Hash, :outer_group do
  it 'is used by RSpec for metadata', :fast, :focus do |example|
    pp example.metadata
  end

  context 'on a nested group' do
    it 'is also inherited' do |example|
      pp example.metadata
    end
  end
end
