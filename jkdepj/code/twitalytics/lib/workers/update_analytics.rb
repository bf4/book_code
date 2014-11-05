#---
# Excerpted from "Deploying with JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jkdepj for more book information.
#---
class UpdateAnalytics
  @queue = :normal

  def self.perform(status_ids)
    puts "The analytics worker is running"
    statuses = status_ids.map  do |status_id|
      status = Status.find(status_id)
      status.preprocess!
      status
    end
    Analytics.refresh(statuses)
  end
end