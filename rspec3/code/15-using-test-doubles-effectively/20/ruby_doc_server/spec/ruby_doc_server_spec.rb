#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'ruby_doc_server'
require 'stringio'

RSpec.describe RubyDocServer do
  it 'finds matching ruby methods' do
    result = get('/Array/min')

    expect(result.split("\n")).to eq [
      'Content-Type: application/json',
      '',
      '["min","min_by","minmax","minmax_by"]'
    ]
  end

  def get(path)
    output = StringIO.new
    RubyDocServer.new(output: output).process_request(path)
    output.string
  end
end
