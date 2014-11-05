#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
module Encryptor
  module ActiveRecord
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def encrypt(attribute, options = {})
        encryptor = Encryptor.new(attribute, options)
        before_save(encryptor)
        after_save(encryptor)
        after_find(encryptor)
        define_method(:after_find) { }
      end
    end
  end
end