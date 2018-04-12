#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'tempfile'
require 'pstore'

class FileKVStore
  def initialize(filename = Tempfile.new('pstore').path)
    @pstore = PStore.new(filename)
  end

  def store(key, value)
    @pstore.transaction do
      @pstore[key] = value
    end
  end

  def fetch(key)
    @pstore.transaction do
      @pstore.fetch(key)
    end
  rescue PStore::Error => e
    raise KeyError, e.message
  end
end
