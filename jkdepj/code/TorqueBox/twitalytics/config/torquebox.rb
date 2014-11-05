#---
# Excerpted from "Deploying with JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jkdepj for more book information.
#---
TorqueBox.configure do
  pool :web, :type => :shared

  job DeleteOldStatuses do
    cron "0 0/5 * * * ?"
    config do
      max_age 30
    end
  end

  service TwitterStreamService

  options_for Backgroundable, :concurrency => 10

  topic '/topics/statuses' do
    processor AnalyticsProcessor
  end

  stomp do
    host 'localhost'
  end

  stomplet StatusStomplet do
    route '/stomp/status'
  end

end
