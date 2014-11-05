#---
# Excerpted from "Deploying with JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jkdepj for more book information.
#---
class DeleteOldStatuses < TrinidadScheduler.Cron "0 0/5 * * * ?"
  def run
    ActiveRecord::Base.connection_pool.with_connection do
      ids = Status.where("created_at < ?", 30.days.ago)

      if ids.size > 0
        Status.destroy(ids)
        puts "#{ids.size} statuses have been deleted!"
      else
        puts "No statuses have been deleted."
      end
    end
  end
end
