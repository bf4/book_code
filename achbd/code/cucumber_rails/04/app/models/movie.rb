#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
class Movie < ActiveRecord::Base
  
  def showtime
    "#{formatted_date} (#{formatted_time})"
  end
  
  def formatted_date
    showtime_date.strftime("%B %d, %Y")
  end
  
  def formatted_time
    showtime_time.strftime("%l:%M%p").strip.downcase
  end
  
end
