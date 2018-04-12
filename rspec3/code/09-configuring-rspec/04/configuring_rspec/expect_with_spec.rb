#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'wrong'

RSpec.configure do |config|
  config.expect_with :minitest, :rspec, Wrong
end

RSpec.describe 'Using different assertion/expectation libraries' do
  let(:result) { 2 + 2 }

  it 'works with minitest assertions' do
    assert_equal 4, result
  end

  it 'works with rspec expectations' do
    expect(result).to eq 4
  end

  it 'works with wrong' do
    # "Where 2 and 2 always makes 5..."
    assert { result == 5 }
  end
end
