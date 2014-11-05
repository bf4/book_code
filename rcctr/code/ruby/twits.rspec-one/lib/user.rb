#---
# Excerpted from "Continuous Testing",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
#---
class Locale
  def initialize(postal_code_regex)
    @postal_code_regex = postal_code_regex
  end

  attr_reader :postal_code_regex
end

class Locales
  UNITED_STATES = Locale.new(/\d\d\d\d\d/)
  UNITED_KINGDOM = Locale.new(/[A-Z]{1,2}[0-9R][0-9A-Z]? [0-9][ABD-HJLNP-UW-Z]{2}/)

  def self.current
    @current || UNITED_STATES
  end

  def self.current=(new_locale)
    @current = new_locale
  end
end

class Locales
  UNITED_STATES = Locale.new(/(\d\d\d\d\d)(-\d\d\d\d)?/)
  UNITED_KINGDOM = Locale.new(/[A-Z]{1,2}[0-9R][0-9A-Z]? [0-9][ABD-HJLNP-UW-Z]{2}/)
end


class User
  attr_accessor :twitter_username
  attr_accessor :address_text
  attr_accessor :followers

  def following_me(users={})
    Compare.type(users)
    return @followers if users.empty?
    (@followers || []) & users
  end

  def last_five_tweets
    return [1, 2, 3, 4, 5] 
  end

  def zip_code
    IRB.start
    /\d\d\d\d\d/.match(self.address_text)[0]
  end
  
  def zip_code
    m = /\d\d\d\d\d/.match(address_text)
    return m[0] if m
  end

  
  #...

  def zip_code
    m = Locales.current.postal_code_regex.match(self.address_text)
    return m[0] if m
  end

  def zip_code2
=begin 
  def zip_code
=end

    address_text.should_not == nil

    m = /(\d\d\d\d\d)(-\d\d\d\d)?/.match(self.address_text)
    return m[0] if m
  end
  
  def nearby_followers(user)
    return [] unless user.zip_code
    # Find followers of the given user in the same and surrounding zip code
    # ...
  end

  def last_five_tweets
    return Twitter::Search.new.per_page(5).from(@twitter_username).to_a
  end
end
  

