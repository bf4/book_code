#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'social_activity_stream'
class DiaryEntry < ActiveRecord::Base
  belongs_to :user
  after_create :post_notice_to_social_stream
  def post_notice_to_social_stream
    SocialActivityStream.notice(:user => user.social_stream_id,
                              :body => %{A new diary entry called
                                #{title} has been created. Check it out!})
  end
end
