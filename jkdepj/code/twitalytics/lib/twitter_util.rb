#---
# Excerpted from "Deploying with JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jkdepj for more book information.
#---
require 'securerandom'

module TwitterUtil

  # a mock twitter interface to replace the EOL'ed v1.0 API
  class Twitter

    class << self
      def update(text)
        # do nothing
      end

      def user_timeline(username, opts)
        (0..20).map {
          __create_mock_for_user(
              username,
              DateTime.parse("20130#{rand(3)+1}0#{rand(28)+1}T0#{rand(9)+1}#{rand(5)+1}#{rand(9)+1}#{rand(5)+1}#{rand(9)+1}+0700"))
        }.sort {|x,y| y["created_at"] <=> x["created_at"] }
      end

      def search(keywords_str, opts)
        keywords = keywords_str.split(" ")

        max = opts[:rpp]
        max ||= opts[:per_page]
        max ||= rand(3)

        (0..max).map { __create_mock_tweet(keywords) }
      end

      def __random_text(keywords)
        text_ary = (1..(rand(15)+5)).map {
          (1..(rand(8)+2)).map { rand(26).to_s(26) }.join # random words
        }
        text_ary[rand(text_ary.size)] = keywords[rand(keywords.size)] unless keywords.empty? # randomly use keyword
        text_ary.join(" ")[0..140]
      end

      def __random_name
        "#{ (1..(rand(10)+2)).map{ rand(26).to_s(26) }.join }"
      end

      def __create_mock_tweet(keywords=[])
        Tweet.new(
            SecureRandom.hex(13),
            DateTime.now,
            __random_name,
            __random_text(keywords)
        )
      end

      def __create_mock_for_user(username, date)
        Tweet.new(
            SecureRandom.hex(13),
            date,
            username,
            __random_text([])
        )
      end
    end
  end

  Tweet = Struct.new(:id, :created_at, :from_user, :text)

  def fetch_recent_tweets(num)
    with_twitter_stream_config do |keywords|
      Twitter.search(
        keywords.join(" "), {:result_type=>"recent", :rpp=>num}
      ).each {|t|}
    end
  end

  def fetch_tweets_since(since_id)
    with_twitter_stream_config do |keywords|
      if since_id
        results = Twitter.search(
            keywords.join(" "), {:result_type=>"recent", :since_id=>"since_id"}
        ).each {|t|}
      else
        results = Twitter.search(
            keywords.join(" "), {:result_type=>"recent", :per_page=>20}
        ).each {|t|}
      end
      results.sort{|x,y| x["created_at"] <=> y["created_at"]}.each {|r| yield r }
      results
    end
  end

  def with_twitter_account
    cnfg = YAML.load_file("#{Rails.root}/config/twitter.yml")
    yield cnfg['username']
  end

  def with_twitter_stream_config
    cnfg = YAML.load_file("#{Rails.root}/config/twitter.yml")
    yield cnfg['keywords']
  end
end
