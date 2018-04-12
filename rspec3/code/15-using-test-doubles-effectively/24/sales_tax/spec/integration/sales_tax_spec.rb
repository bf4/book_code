#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'sales_tax'

RSpec.describe SalesTax do
  let(:sales_tax) { SalesTax.new }

  it 'can fetch the tax rate for a given zip' do
    rate = sales_tax.rate_for('90210')
    expect(rate).to be_a(Float).and be_between(0.01, 0.5)
  end

  it 'raises an error if the tax rate cannot be found' do
    expect {
      sales_tax.rate_for('00000')
    }.to raise_error(SalesTax::RateUnavailableError)
  end
end
