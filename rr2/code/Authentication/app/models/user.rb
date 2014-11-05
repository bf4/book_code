#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'digest/sha2'
class User < ActiveRecord::Base
  def password=(pass)
    salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
    self.password_salt, self.password_hash =
      salt, Digest::SHA256.hexdigest(pass + salt)
  end
end
require 'digest/sha2'
class User < ActiveRecord::Base
  validates_uniqueness_of :username  
  
  def self.authenticate(username, password)
    user = User.find(:first, :conditions => ['username = ?', username])
    if user.blank? || 
      Digest::SHA256.hexdigest(password + user.password_salt) != user.password_hash
      raise "Username or password invalid" 
    end
    user
  end
end
