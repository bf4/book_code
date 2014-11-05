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
  #   Rails.env == "production"
  #
  # you can call this:
  #
  #   Rails.env.production?
  #
  class StringInquirer < String
    def method_missing(method_name, *arguments)
      if method_name.to_s[-1,1] == "?"
        self == method_name.to_s[0..-2]
      else
        super
      end
    end
  end
end
