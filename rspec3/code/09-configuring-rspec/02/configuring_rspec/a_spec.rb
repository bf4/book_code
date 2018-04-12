#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
RSpec.describe 'A group with a failure' do
  it 'has an example that fails' do
    expect(1).to eq 2
  end

  it 'has an example that succeeds' do
    expect(1).to eq 1
  end
end

RSpec.describe 'Another group with a failure' do
  it 'has an example that fails' do
    expect(1).to eq 2
  end

  it 'has an example that succeeds' do
    expect(1).to eq 1
  end
end
