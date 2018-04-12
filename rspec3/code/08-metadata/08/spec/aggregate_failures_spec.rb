#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
RSpec.describe ':aggregate_failures' do
  it 'has :aggregate_failures by default' do |example|
    expect(example.metadata).to include(aggregate_failures: true)
  end

  it 'can disable :aggregate_failures', aggregate_failures: false do |example|
    expect(example.metadata).to include(aggregate_failures: false)
  end
end
