#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class User < ActiveRecord::Base
  has_secure_password
end
class User < ActiveRecord::Base
  has_secure_password
  validates_uniqueness_of :username

  def self.authenticate(username, password)
    user = User.find_by_username(username)
    unless user && user.authenticate(password)
      raise "Username or password invalid"
    end
    user
  end
end
