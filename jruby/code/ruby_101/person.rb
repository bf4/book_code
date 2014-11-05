#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
class Locator
  def initialize(location)
    @location = location
  end
end

class PhoneNumber < Locator
  def valid?
    @location =~ /^\d{3}-\d{3}-\d{4}$/
  end
end

class Address < Locator
  def valid?
    @location =~ /^\d+ .+$/
  end
end

class Person
  def initialize
    @locators = []
  end

  def add_phone_number string
    number = PhoneNumber.new(string)
    @locators << number if number.valid?
  end

  def add_address string
    address = Address.new(string)
    @locators << address if address.valid?
  end
end

ola = Person.new

# The following locators get added,
# because they're in the right format:
ola.add_phone_number '555-231-4555'
ola.add_address("1 Did It My Way")

# The following locator gets ignored,
# because it's not a valid US phone number:
ola.add_phone_number '42'
