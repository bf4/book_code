#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'berlin_transit_ticket'

# We disable line length because the labels cause lines to be too long
# but they do not render in the book so it causes no problems.
# rubocop:disable Metrics/LineLength
RSpec.describe BerlinTransitTicket do
  let(:ticket) { BerlinTransitTicket.new } 

  before do 
    # These values depend on `let` definitions
    # defined in the nested contexts below!
    #
    ticket.starting_station = starting_station 
    ticket.ending_station   = ending_station   
  end

  let(:fare) { ticket.fare } 

  context 'when starting in zone A' do
    let(:starting_station) { 'Bundestag' }    

    context 'and ending in zone B' do
      let(:ending_station) { 'Leopoldplatz' } 

      it 'costs €2.70' do 
        expect(fare).to eq 2.7
      end
    end

    context 'and ending in zone C' do
      let(:ending_station) { 'Birkenwerder' }

      it 'costs €3.30' do
        expect(fare).to eq 3.3
      end
    end
  end
end
# rubocop:enable Metrics/LineLength
