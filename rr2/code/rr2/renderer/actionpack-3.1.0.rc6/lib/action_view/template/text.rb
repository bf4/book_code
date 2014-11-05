#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActionView #:nodoc:
  # = Action View Text Template
  class Template
    class Text < String #:nodoc:
      attr_accessor :mime_type

      def initialize(string, mime_type = nil)
        super(string.to_s)
        @mime_type   = Mime[mime_type] || mime_type if mime_type
        @mime_type ||= Mime::TEXT
      end

      def identifier
        'text template'
      end

      def inspect
        'text template'
      end

      def render(*args)
        to_s
      end

      def formats
        [@mime_type.to_sym]
      end
    end
  end
end
