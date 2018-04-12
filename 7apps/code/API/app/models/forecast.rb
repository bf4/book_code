#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
class Forecast

  attr_accessor :date, :day, :high, :low, :text

  def self.from_hash(hash)
    Forecast.new.tap do |f|
      f.date  = hash["date"]
      f.day   = hash["day"]
      f.high  = hash["high"]
      f.low   = hash["low"]
      f.text  = hash["text"]
    end
  end

end
