#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# encoding: utf-8

require 'uri'
str = "\xE6\x97\xA5\xE6\x9C\xAC\xE8\xAA\x9E" # Ni-ho-nn-go in UTF-8, means Japanese.
parser = URI::Parser.new

unless str == parser.unescape(parser.escape(str))
  URI::Parser.class_eval do
    remove_method :unescape
    def unescape(str, escaped = /%[a-fA-F\d]{2}/)
      # TODO: Are we actually sure that ASCII == UTF-8?
      # YK: My initial experiments say yes, but let's be sure please
      enc = str.encoding
      enc = Encoding::UTF_8 if enc == Encoding::US_ASCII
      str.gsub(escaped) { [$&[1, 2].hex].pack('C') }.force_encoding(enc)
    end
  end
end

module URI
  class << self
    def parser
      @parser ||= URI::Parser.new
    end
  end
end
