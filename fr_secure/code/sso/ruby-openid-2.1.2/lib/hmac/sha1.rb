#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require 'hmac/hmac'
require 'digest/sha1'

module HMAC
  class SHA1 < Base
    def initialize(key = nil)
      super(Digest::SHA1, 64, 20, key)
    end
    public_class_method :new, :digest, :hexdigest
  end
end
