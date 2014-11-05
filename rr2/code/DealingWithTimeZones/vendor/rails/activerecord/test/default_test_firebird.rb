#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'abstract_unit'
require 'fixtures/default'

class DefaultTest < Test::Unit::TestCase
  def test_default_timestamp
    default = Default.new
    assert_instance_of(Time, default.default_timestamp)
    assert_equal(:datetime, default.column_for_attribute(:default_timestamp).type)

    # Variance should be small; increase if required -- e.g., if test db is on
    # remote host and clocks aren't synchronized.
    t1 = Time.new
    accepted_variance = 1.0
    assert_in_delta(t1.to_f, default.default_timestamp.to_f, accepted_variance)
  end
end
