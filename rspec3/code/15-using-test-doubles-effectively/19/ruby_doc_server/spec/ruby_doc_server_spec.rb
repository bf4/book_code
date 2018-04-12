#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'ruby_doc_server'

RSpec.describe RubyDocServer do
  it 'finds matching ruby methods' do
    out = get('/Array/max')

    expect(out).to have_received(:puts).with('Content-Type: application/json')
    expect(out).to have_received(:puts).with('["max","max_by"]')
  end

  def get(path)
    output = object_spy($stdout)
    RubyDocServer.new(output: output).process_request(path)
    output
  end
end
