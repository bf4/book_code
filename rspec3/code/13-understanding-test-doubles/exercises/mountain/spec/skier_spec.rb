#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'skier'

module Mountain
  RSpec.describe Skier do
    it 'gets tired after skiing a difficult slope' do
      trail_map = instance_double('TrailMap', difficulty: :expert)

      skier = Skier.new(trail_map)
      skier.ski_on('Last Hoot')
      expect(skier).to be_tired
    end
  end
end
