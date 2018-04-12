#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'uri'

RSpec.shared_examples 'a URI parsing library' do |library|
  it 'parses the scheme' do
    expect(library.parse('https://a.com/').scheme).to eq 'https'
  end

  it 'parses the host' do
    expect(library.parse('http://foo.com/').host).to eq 'foo.com'
  end

  it 'parses the port' do
    expect(library.parse('http://example.com:9876').port).to eq 9876
  end

  it 'parses the path' do
    expect(library.parse('http://a.com/foo').path).to eq '/foo'
  end
end
