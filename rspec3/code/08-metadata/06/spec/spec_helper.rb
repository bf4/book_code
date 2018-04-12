#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
RSpec.configure do |config|
  config.define_derived_metadata(type: :model) do |meta|
    # ...
    meta[:matched_by_type_model] = true
  end
end

RSpec.describe do
  it 'matches type: :model', type: :model do |example|
    expect(example.metadata).to include(matched_by_type_model: true)
  end
end
