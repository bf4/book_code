#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
PublicCompany = Struct.new(:name, :value_per_share, :share_count) do
  def got_better_than_expected_revenues
    self.value_per_share *= rand(1.05..1.10)
  end

  def market_cap
    @market_cap ||= value_per_share * share_count
  end
end

RSpec.describe PublicCompany do
  let(:company) { PublicCompany.new('Nile', 10, 100_000) }

  it 'increases its market cap when it gets better than expected revenues' do
    expect {
      company.got_better_than_expected_revenues
    }.to change(company, :market_cap).by_at_least(50_000)
  end

  it 'provides attributes' do
    expect(company).to have_attributes(
      name: 'Nil',
      value_per_share: 10,
      share_count: 10_000,
      market_cap: 1_000_000
    )
  end

end
