#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class User < ActiveRecord::Base
  
  validates_confirmation_of :password
  
  class InvalidLoginException < Exception; end

  def self.authenticate(email, password)
    user = self.find(:first, :conditions => ["email = ?", email])
    raise InvalidLoginException.new("E-Mail address or password not found".t) if user.nil?
    if(user.password == self.password_hash(password)) 
      user
    else
      raise InvalidLoginException.new("E-Mail address or password not found".t)
    end
  end
  
  def self.password_hash(password)
    MD5.hexdigest(password+'<Globalize Recipe>')
  end
    
end
