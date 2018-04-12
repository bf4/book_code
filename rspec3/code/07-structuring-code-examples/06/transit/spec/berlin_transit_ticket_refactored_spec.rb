#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'berlin_transit_ticket'

RSpec.describe BerlinTransitTicket do
  def fare_for(starting_station, ending_station)
    ticket = BerlinTransitTicket.new
    ticket.starting_station = starting_station
    ticket.ending_station   = ending_station
    ticket.fare
  end

  context 'when starting in zone A and ending in zone B' do
    it 'costs €2.70' do
      expect(fare_for('Bundestag', 'Leopoldplatz')).to eq 2.7
    end
  end

  context 'when starting in zone A and ending in zone C' do
    it 'costs €3.30' do
      expect(fare_for('Bundestag', 'Birkenwerder')).to eq 3.3
    end
  end
end
