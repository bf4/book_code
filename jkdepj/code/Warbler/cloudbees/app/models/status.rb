#---
# Excerpted from "Deploying with JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jkdepj for more book information.
#---
class Status < ActiveRecord::Base

  def self.find_or_create_from(tweets)
    r = tweets.map do |tweet|
      existing = Status.where(:remote_id => tweet.id.to_s).first
      begin
        existing.nil? ?
            Status.create(
              :created_at => tweet.created_at,
              :status_text => tweet.text,
              :creator => tweet.from_user,
              :remote_id => tweet.id.to_s
            ) :
            existing
      rescue => e
        # probably some bad characters in the tweet
        nil
      end
    end.compact

    #Resque.enqueue(UpdateAnalytics, r.map(&:id))

    r
  end

  def retweet
    sleep(10)
    # Twitter.update("RT @#{creator}: {status_text}")
    puts "Retweeting Status{id=#{id}}"
  end
  
  def preprocess!
    set_positivity_score!
    set_followers_count!
    self.save
  end

  def positivity_score
    read_attribute(:positivity_score) || 0
  end

  def followers_count
    read_attribute(:followers_count) || 0
  end

  private

  def set_positivity_score!
    # some simple parsing to determine if the tweet is positive or negative
    score = 0
    self.status_text.scan(/happy|great|love/).each { score += 1 }
    self.status_text.scan(/hate|bad|angry/).each { score -= 1 }
    self.status_text.scan(/:\)/).each { score += 5 }
    self.status_text.scan(/:\(/).each { score -= 5 }
    self.status_text.scan(/#ftw/).each { score += 15 }
    self.status_text.scan(/#fail/).each { score -= 15 }
    self.status_text.scan(/!/).each { score *= 2 }
    write_attribute(:positivity_score, score)
  end

  def set_followers_count!
    # any way we try to do this without an OAuth token will cause us to exceed our rate-limit very quickly
    # user = Twitter.user(creator)
    # write_attribute(:followers_count, user ? user.followers_count : 0)
    if read_attribute(:followers_count).nil?
      write_attribute(:followers_count, rand(1000))
    end
  rescue
    # we probably exceeded our Twitter rate-limit :(
    write_attribute(:followers_count, 0)
  end
end
