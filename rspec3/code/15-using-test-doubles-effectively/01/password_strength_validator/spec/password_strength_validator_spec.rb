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
  it 'rejects passwords shorter than 8 characters' do
    validator = PasswordStrengthValidator.new('a8E^rd2')
    expect(validator.strong_enough?).to eq false
  end

  it 'accepts passwords 8 characters or longer' do
    validator = PasswordStrengthValidator.new('a8E^rd2i')
    expect(validator.strong_enough?).to eq true
  end
end
