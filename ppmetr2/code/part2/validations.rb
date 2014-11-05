#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_model'

class User
  include ActiveModel::Validations

  attr_accessor :password
  
  validate do
    errors.add(:base, "Don't let dad choose the password.") if password == '1234'
  end
end

user = User.new
user.password = '12345'
user.valid?        # => true

require_relative '../test/assertions'
assert user.valid?


user.password = '1234'
user.valid?        # => false

assert_false user.valid?

