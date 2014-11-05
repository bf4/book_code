#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'drb/drb'

class DCP
  include DRbUndumped

  def size(fname)
    File.lstat(fname).size
  end

  def fetch(fname)  # (1)
    File.open(fname, 'rb') do |fp|
      while buf = fp.read(4096)
        yield(buf)
      end
    end
    nil
  end

  def store_from(there, fname)   # (2)
    size = there.size(fname)
    wrote = 0

    File.open(fname, 'wb') do |fp|
      there.fetch(fname) do |buf|
        wrote += fp.write(buf)
        yield([wrote, size]) if block_given?
        nil
      end
    end
    wrote
  end

  def copy(uri, fname)
    there = DRbObject.new_with_uri(uri)
    store_from(there, fname) do |wrote, size|
      puts "#{wrote * 100 / size}%"
    end
  end
end

if __FILE__ == $0
  if ARGV[0] == '-server'
    ARGV.shift
    DRb.start_service(ARGV.shift, DCP.new)
    puts DRb.uri
    DRb.thread.join
  else
    uri = ARGV.shift
    fname = ARGV.shift
    raise('usage: dcp.rb URI filename') if uri.nil? || fname.nil?
    DRb.start_service
    DCP.new.copy(uri, fname)
  end
end
