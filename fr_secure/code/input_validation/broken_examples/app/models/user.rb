#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require 'openssl/digest'

class User < ActiveRecord::Base
  
  validates_presence_of :email, :password
  
  def authenticate(password)
    self.password == OpenSSL::Digest::SHA1.new(password).hexdigest
  end
  
  def before_create
    self.password = OpenSSL::Digest::SHA1.new(password).hexdigest
  end
  
end
