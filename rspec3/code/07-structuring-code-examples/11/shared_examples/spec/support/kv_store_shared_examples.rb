#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
RSpec.shared_examples 'KV store' do |kv_store_class|
  let(:kv_store) { kv_store_class.new }

  it 'allows you to fetch previously stored values' do
    kv_store.store(:language, 'Ruby')
    kv_store.store(:os, 'linux')

    expect(kv_store.fetch(:language)).to eq 'Ruby'
    expect(kv_store.fetch(:os)).to eq 'linux'
  end

  it 'raises a KeyError when you fetch an unknown key' do
    expect { kv_store.fetch(:foo) }.to raise_error(KeyError)
  end
end
