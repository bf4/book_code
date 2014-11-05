#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'zlib'
require 'stringio'

module ActiveSupport
  # A convenient wrapper for the zlib standard library that allows
  # compression/decompression of strings with gzip.
  #
  #   gzip = ActiveSupport::Gzip.compress('compress me!')
  #   # => "\x1F\x8B\b\x00o\x8D\xCDO\x00\x03K\xCE\xCF-(J-.V\xC8MU\x04\x00R>n\x83\f\x00\x00\x00"
  #
  #   ActiveSupport::Gzip.decompress(gzip)
  #   # => "compress me!" 
  module Gzip
    class Stream < StringIO
      def initialize(*)
        super
        set_encoding "BINARY"
      end
      def close; rewind; end
    end

    # Decompresses a gzipped string.
    def self.decompress(source)
      Zlib::GzipReader.new(StringIO.new(source)).read
    end

    # Compresses a string using gzip.
    def self.compress(source, level=Zlib::DEFAULT_COMPRESSION, strategy=Zlib::DEFAULT_STRATEGY)
      output = Stream.new
      gz = Zlib::GzipWriter.new(output, level, strategy)
      gz.write(source)
      gz.close
      output.string
    end
  end
end
