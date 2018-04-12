#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'hash_kv_store'
require 'file_kv_store'
require 'support/kv_store_shared_examples'

RSpec.describe 'Key-value stores' do
  include_examples 'KV store', HashKVStore
  include_examples 'KV store', FileKVStore
end
