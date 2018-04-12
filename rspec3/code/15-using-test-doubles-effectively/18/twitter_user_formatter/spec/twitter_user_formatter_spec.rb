#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'twitter_user_formatter'

RSpec.describe TwitterUserFormatter do
  it 'describes their homepage' do
    user = instance_double(Twitter::User,
                           name: 'RSpec',
                           url: 'http://rspec.info')

    formatter = TwitterUserFormatter.new(user)

    expect(formatter.format).to eq("RSpec's website is http://rspec.info")
  end
end
