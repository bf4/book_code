#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
module Encryptor  
  module Routines  
    def encrypt(plain_text, key, opts)
      cipher = OpenSSL::Cipher::Cipher.new(algorithm(opts))
      iv = cipher.random_iv
      cipher.encrypt(key, iv)
      cipher_text = cipher.update(plain_text) 
      cipher_text << cipher.final    
      cipher_text.insert(0,iv)
      Base64.encode64(cipher_text)
    end

    def decrypt(cipher_text, key, opts)
      cipher = OpenSSL::Cipher::Cipher.new(algorithm(opts))
      decoded_cipher_text = Base64.decode64(cipher_text)
      cipher.decrypt(key, decoded_cipher_text.slice!(0..15))
      out = cipher.update(decoded_cipher_text)
      out << cipher.final
    end
    
    def algorithm(opts)
      "#{opts[:cipher]}-#{opts[:keylength]}-#{opts[:block_mode]}"
    end
  end
end