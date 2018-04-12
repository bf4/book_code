#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'date'

Calendar = Struct.new(:date_string) do
  def on_weekend?
    Date.parse(date_string).saturday?
  end
end

RSpec.describe Calendar do
  let(:sunday_date) { Calendar.new('Sun, 11 Jun 2017') }

  it 'considers sundays to be on the weekend' do
    expect(sunday_date.on_weekend?).to be true
  end
end
