#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
module HasReference

  extend ActiveSupport::Concern

  module ClassMethods

    def generate_reference(length: 10, attribute: :reference)
      loop do
        result = SecureRandom.hex(length)
        return result unless exists?(attribute => result)
      end
    end

  end

end
