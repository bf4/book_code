#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class User < ActiveRecord::Base
  has_many :task_reminders, :order => "due_at"
end
class User < ActiveRecord::Base
  has_many :task_reminders, :order => "due_at"
  composed_of :tz,
              :class_name => 'TimeZone', 
              :mapping => %w(time_zone name)
end
