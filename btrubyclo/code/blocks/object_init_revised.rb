#---
# Excerpted from "Mastering Ruby Closures",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/btrubyclo for more book information.
#---
module Twitter
  module REST
    class Client
      attr_accessor :consumer_key, :consumer_secret,
                    :access_token, :access_token_secret

      def initialize(options = {}, &block)
        options.each { |k,v| send("#{k}=", v) }
        instance_eval(&block) if block_given?
      end
    end
  end
end

client = Twitter::REST::Client.new({consumer_key: "YOUR_CONSUMER_KEY"}) do
  consumer_secret     = "YOUR_CONSUMER_SECRET"
  access_token        = "YOUR_ACCESS_TOKEN"
  access_token_secret = "YOUR_ACCESS_SECRET"
end

p client.consumer_key # => YOUR_CONSUMER_KEY
p client.access_token # => YOUR_ACCESS_TOKEN
