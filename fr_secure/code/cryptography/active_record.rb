#!/usr/bin/env ruby
#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
#
#  Created by Ben Poweski on 2007-01-18.
#  Copyright (c) 2007. All rights reserved.

require "rubygems"
require_gem "activerecord"


require "openssl/cipher"

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.establish_connection({
  :adapter => "sqlite3", 
  :dbfile => ":memory:" 
})

# build some random key
$ENCRYPTION_KEY = OpenSSL::Cipher::Cipher.new("AES-128-CBC").random_key


ActiveRecord::Schema.define(:version => 1) do
  create_table :users do |t|
    t.column :name, :string
    t.column :secret_question, :string
    t.column :secret_answer, :string
  end
end




module Crypto
  module ActiveRecord
  
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def encrypt(attribute, options = {})
        encrypter = Encrypter.new(attribute, options)
        before_save(encrypter)
        after_save(encrypter)
        after_find(encrypter)
        define_method(:after_find) { }
      end    
    end
    
    module Encryption
      
      @@encryption_key = ''
      cattr_accessor :encryption_key
      
      protected
      
      def encrypt(plain_text)
        cipher = OpenSSL::Cipher::Cipher.new("#{}-#{}-#{}")
        iv = aes.random_iv
        cipher.encrypt($ENCRYPTION_KEY, iv)
        cipher_text = aes.update(plain_text) 
        cipher_text << cipher.final    
        cipher_text.insert(0,iv)
        Base64.encode64(cipher_text)
      end

      def decrypt(cipher_text)
        cipher = OpenSSL::Cipher::Cipher.new("128-CBC")    
        decoded_cipher_text = Base64.decode64(cipher_text)
        cipher.decrypt($ENCRYPTION_KEY, decoded_cipher_text.slice!(0..15))
        out = cipher.update(decoded_cipher_text)
        out << cipher.final
      end      
    end
    
    class Encrypter
      alias_method :after_find, :after_save

      def initialize(field, opts = {})
        @field = field
        @options = {:cipher => 'AES', :block_mode => 'CBC', :keylength => 128}.merge(opts)
      end

      def before_save(model)
        model[@field] = encrypt(model[@field]) unless model[@field].blank?
      end

      def after_save(model)
        model[@field] = decrypt(model[@field]) unless model[@field].blank?
      end
    end    
  end
end


# mixin
ActiveRecord::Base.send(:include, Crypto::ActiveRecord)


class User < ActiveRecord::Base
  encrypt :secret_answer
end



user = User.new do |u|
  u.name = "Ben Poweski"
  u.secret_question = "What is your favorite food?"
  u.secret_answer = "tacos"
end

user.save 


puts "user.secret_answer:      #{user.secret_answer}"
puts "user[:secret_answer]     #{user[:secret_answer]}"
