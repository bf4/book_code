#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveSupport
  # Wrapping a string in this class gives you a prettier way to test
  # for equality. The value returned by <tt>Rails.env</tt> is wrapped
  # in a StringInquirer object so instead of calling this:
  #
  #   Rails.env == 'production'
  #
  # you can call this:
  #
  #   Rails.env.production?
  class StringInquirer < String
    private

      def respond_to_missing?(method_name, include_private = false)
        method_name[-1] == '?'
      end

      def method_missing(method_name, *arguments)
        if method_name[-1] == '?'
          self == method_name[0..-2]
        else
          super
        end
      end
  end
end
