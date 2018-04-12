#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
class PointOfSale
  def self.purchase(item, with: nil)
    with.charge(item.cost)
  end
end

RSpec.configure do |config|
  config.mock_with :mocha
end

RSpec.describe 'config.mock_with :mocha' do
  it 'allows you to use mocha instead of rspec-mocks' do
    item = stub('Book', cost: 17.50)

    credit_card = mock('CreditCard')
    credit_card.expects(:charge).with(17.50)

    PointOfSale.purchase(item, with: credit_card)
  end
end
