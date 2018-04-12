#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
# validate me
require 'rspec/expectations'
include RSpec::Matchers
require 'rspec/mocks/standalone'

class PasswordHash
  COST_FACTOR = 12

  # ...
end

stub_const('PasswordHash::COST_FACTOR', 1)

expect(PasswordHash::COST_FACTOR).to eq 1

hide_const('ActiveRecord')
