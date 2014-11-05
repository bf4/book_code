#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support/string_inquirer'

class String
  # Wraps the current string in the <tt>ActiveSupport::StringInquirer</tt> class,
  # which gives you a prettier way to test for equality.
  #
  #   env = 'production'.inquiry
  #   env.production?  # => true
  #   env.development? # => false
  def inquiry
    ActiveSupport::StringInquirer.new(self)
  end
end
