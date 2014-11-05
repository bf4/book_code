#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
require 'locales'

class User
  attr_accessor :twitter_username, :address_text

  def zip_code
    m = /\d\d\d\d\d/.match(address_text)
    return m[0] if m
  end
  
  def nearby_followers(user)
    return [] unless user.zip_code
    # Find followers of the given user in the same and surrounding zip code
    # ...
  end
end
