#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---

module ActiveRecord
  class Base
    def self.encryption_key=(key)
      write_inheritable_attribute :encryption_key, key
    end
    
    def self.encryption_key
      read_inheritable_attribute :encryption_key
    end
  end
end



module Encryptor
  module ActiveRecord
    class Encryptor
      include ::Encryptor::Routines
  
      @@default_options = {
        :cipher => 'AES', :block_mode => 'CBC', :keylength => 128
      }

      def self.default_options
        @@default_options
      end

      def initialize(field, opts = {})
        @field = field
        @options = @@default_options.merge(opts)
      end

      def before_save(model)
        unless model[@field].blank?
          key = model.class.encryption_key
          model[@field] = encrypt(model[@field], key, @options) 
        end
      end

      def after_save(model)
        unless model[@field].blank?
          key = model.class.encryption_key
          model[@field] = decrypt(model[@field], key, @options)
        end
      end
  
      alias_method :after_find, :after_save      
    end
  end
end
