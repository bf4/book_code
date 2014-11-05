#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'abstract_unit'
# require File.dirname(__FILE__) + '/../dev-utils/eval_debugger'
require 'fixtures/customer'

class AggregationsTest < Test::Unit::TestCase
  def setup
    @customers = create_fixtures "customers"
    @david = Customer.find(1)
  end

  def test_find_single_value_object
    assert_equal 50, @david.balance.amount
    assert_kind_of Money, @david.balance
    assert_equal 300, @david.balance.exchange_to("DKK").amount
  end
  
  def test_find_multiple_value_object
    assert_equal @customers["david"]["address_street"], @david.address.street
    assert(
      @david.address.close_to?(Address.new("Different Street", @customers["david"]["address_city"], @customers["david"]["address_country"]))
    )
  end
  
  def test_change_single_value_object
    @david.balance = Money.new(100)
    @david.save
    assert_equal 100, Customer.find(1).balance.amount
  end
  
  def test_immutable_value_objects
    @david.balance = Money.new(100)
    assert_raises(TypeError) {  @david.balance.instance_eval { @amount = 20 } }
  end  
end