#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
if RUBY_VERSION >= '1.9'
  require 'uri'

  str = "\xE6\x97\xA5\xE6\x9C\xAC\xE8\xAA\x9E" # Ni-ho-nn-go in UTF-8, means Japanese.
  str.force_encoding(Encoding::UTF_8) if str.respond_to?(:force_encoding)

  unless str == URI.unescape(URI.escape(str))
    URI::Parser.class_eval do
      remove_method :unescape
      def unescape(str, escaped = @regexp[:ESCAPED])
        enc = (str.encoding == Encoding::US_ASCII) ? Encoding::UTF_8 : str.encoding
        str.gsub(escaped) { [$&[1, 2].hex].pack('C') }.force_encoding(enc)
      end
    end
  end
end
