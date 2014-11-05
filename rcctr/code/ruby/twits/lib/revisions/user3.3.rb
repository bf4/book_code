#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
require 'twitter'
require 'locales'

class User
  attr_accessor :twitter_username, :address_text, :followers

  #...

  def following_me(users={})
    Compare.type(users)
    return @followers if users.empty?
    (@followers || []) & users
  end
end
