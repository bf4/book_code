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

  def zip_code
    Locales.current.parse_postal_code(@address_text)
  end

  def last_five_tweets
    return Twitter::Search.new.per_page(5).from(@twitter_username).map do |tweet|
      tweet[:text]
    end
  end

  def following_me(users={})
    return @followers if users.empty?
    (@followers || []) & users
  end

  def nearby_followers(user)
    return [] unless user.zip_code
    # Find followers of the given user in the same and surrounding zip code
    # ...
  end
end
