#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
class AvatarAdapter

  attr_accessor :user, :client

  def initialize(user)
    @user = user
  end

  def client
    @client ||= begin
      Twitter::REST::Client.new(
        consumer_key: Rails.application.secrets.twitter_api,
        consumer_secret: Rails.application.secrets.twitter_secret)
    end
  end

  def image_url
    client.user(user.twitter_handle).profile_image_uri(:bigger).to_s
  end

end
