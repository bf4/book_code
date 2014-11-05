#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
RSpec::Matchers.define :be_of_size do |expected|
  match do |actual|
    actual.total_size == expected
  end

  description do
    "have tasks totaling #{expected} points"
  end

  failure_message do |actual|
    "expected project #{actual.name} to have size #{expected}"
  end

  failure_message_when_negated do |actual|
    "expected project #{actual.name} not to have size #{expected}"
  end


end

