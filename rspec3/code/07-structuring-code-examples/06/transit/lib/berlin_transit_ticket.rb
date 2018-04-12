#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
class BerlinTransitTicket
  attr_accessor :starting_station, :ending_station

  def fare
    if starting_station == 'Bundestag' && ending_station == 'Leopoldplatz'
      2.7
    elsif starting_station == 'Bundestag' && ending_station == 'Birkenwerder'
      3.3
    else
      raise 'price has not been defined'
    end
  end
end
