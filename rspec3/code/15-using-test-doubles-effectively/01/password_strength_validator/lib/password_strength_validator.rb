#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'configuration'

class PasswordStrengthValidator

  attr_reader :password

  def initialize(password)
    @password = password
  end

  def strong_enough?
    return false unless password.length >= Acme::Config.min_password_length

    # ... more validations ...
    true
  end
end
