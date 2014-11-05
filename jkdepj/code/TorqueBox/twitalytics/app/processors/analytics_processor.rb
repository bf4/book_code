#---
# Excerpted from "Deploying with JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jkdepj for more book information.
#---
class AnalyticsProcessor < TorqueBox::Messaging::MessageProcessor
  def on_message(body)
    # receive messages from broker
    statuses = JSON.parse(body).map  do |s|
      status = Status.find(s['id'])
      status.preprocess!
      status
    end
    Analytics.refresh(statuses)
  end
end



