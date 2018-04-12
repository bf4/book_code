#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'password_strength_validator'

RSpec.describe PasswordStrengthValidator do
  before do
    allow(Acme::Config).to receive(:min_password_length).and_return(6)
  end

  it 'rejects passwords shorter than the configured length' do
    validator = PasswordStrengthValidator.new('a8E^r')
    expect(validator.strong_enough?).to eq false
  end

  it 'accepts passwords that satisfy the configured length' do
    validator = PasswordStrengthValidator.new('a8E^rd')
    expect(validator.strong_enough?).to eq true
  end
end
