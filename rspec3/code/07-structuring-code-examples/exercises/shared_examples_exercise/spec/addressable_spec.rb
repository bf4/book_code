#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'addressable'

RSpec.describe Addressable do
  it 'parses the scheme' do
    expect(Addressable::URI.parse('https://a.com/').scheme).to eq 'https'
  end

  it 'parses the host' do
    expect(Addressable::URI.parse('https://foo.com/').host).to eq 'foo.com'
  end

  it 'parses the port' do
    expect(Addressable::URI.parse('http://example.com:9876').port).to eq 9876
  end

  it 'parses the path' do
    expect(Addressable::URI.parse('http://a.com/foo').path).to eq '/foo'
  end
end
