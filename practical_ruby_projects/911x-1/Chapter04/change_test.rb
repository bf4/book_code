require 'test/unit'
require 'change.rb'

# Tests maybe should not be written with direct comparision of the coins
# slot. Probably should have some other function that compares size and number
# of coins (ie "goodness").

class CustomerTest < Test::Unit::TestCase
  def test_amount
    customer = Customer.us(1, 1, 10, 10, 25, 25)
    assert_equal(72, customer.amount)
  end

  def test_to_s
    customer = Customer.us(1, 1, 10, 10, 25, 25)
    assert_equal("$0.72 (1, 1, 10, 10, 25, 25)", customer.to_s)
  end

  def test_equality
    one = Customer.us(1, 1, 10, 10, 25, 25)
    two = Customer.us(1, 1, 10, 10, 25, 25)
    assert_equal(one, two)
  end

  def test_number
    customer = Customer.us(1, 1, 10, 10, 25, 25)
    assert_equal(6, customer.number)
  end

  def test_pay!
    customer = Customer.us(1, 1)
    assert_equal(Customer.us(10, 10, 25, 25, 25), customer.pay!(7))
  end
  
  def test_more_pay!
    customer  = Customer.us(1, 1, 10, 10, 25, 25) # 72
    answer = Customer.us(1, 1, 5, 25, 25, 25)  # 82
    customer.pay!(90)

    assert_equal(answer, customer)
  end

  def test_more2_pay!
    customer  = Customer.us(1, 1, 1, 1)
    answer = Customer.us(25)
    customer.pay!(79)

    assert_equal(answer, customer)
  end

  def test_less_pay!
    customer  = Customer.new([1, 5, 10], 1, 1, 1, 1, 5, 10, 10)
    answer = Customer.new([1, 5, 10], 10)

    customer.pay!(19)

    assert_equal(10, customer.amount)
    assert_equal(answer, customer)
  end

  def test_pay_again!
    customer = Customer.us(1, 1, 1, 1, 10, 10)
    customer.pay!(12)
    answer = Customer.us(1, 1, 10)

    assert_equal(answer, customer)
  end

  def test_multi_pay!
    customer = Customer.new([1])
    customer.pay!(60)
    customer.pay!(65)
    # No assertion because it triggers an error
  end
end

class MakeChangeTest < Test::Unit::TestCase
  def test_1
    cm = ChangeMaker.new(1)
    assert_equal([1], cm.change(1))
  end

  def test_2
    cm = ChangeMaker.new(1, 2)
    assert_equal([1, 2], cm.change(3))
  end

  def test_3
    cm = ChangeMaker.new(1, 5, 10, 25)
    assert_equal([5, 25, 25], cm.change(55))
  end

  def test_4
    cm = ChangeMaker.new(1, 5, 10, 25)
    assert_equal([1, 1, 1, 1, 5, 25, 25, 25], cm.change(84))
  end

  def test_5
    cm = ChangeMaker.new(1, 7, 10, 25)
    assert_equal([7, 7], cm.change(14))
  end

  def test_6
    cm = ChangeMaker.new(1, 2, 3, 5, 7, 11)
    assert_equal([1, 11, 11, 11, 11, 11], cm.change(56))
  end
end

class PricesTest < Test::Unit::TestCase
  def test_get1
    prices = Prices.new(5, 6, 7)
    assert([5, 6, 7].include?(prices.get))
  end

  def test_each
    prices = Prices.new(5, 6, 7)
    results = []
    prices.each(5) {|x| results.push x }
    assert_equal(5, results.size)
    assert(results.all?{|x| [5, 6, 7].include?(x) })
  end
end

class ChangeSimulatorTest < Test::Unit::TestCase
  def test_new
    prices = Prices.new(75, 99)
    cs   = ChangeSimulator.new(prices, 1, 5, 10)
    assert(cs)
  end

  def test_run
    prices = Prices.new(75, 99)
    cs   = ChangeSimulator.new(prices, 1, 5, 10)
    assert(cs.run(1).kind_of?(Numeric))
  end
end

class ExtensionsTest < Test::Unit::TestCase
  def test_permutations_empty
    assert_equal([[]], [].permutations)
  end

  def test_permutations
    answer = [[], [1], [1, 2], [1, 2, 3], [1, 3], [2], [2, 3], [3]]
    assert_equal(answer, [1, 2, 3].permutations.sort)
  end

  def test_permutations_of_size
    answer = [[1, 2], [1, 3], [2, 3]]
    assert_equal(answer, [1, 2, 3].permutations_of_size(2))
  end

  def test_sum
    assert_equal(2, [1, 2, 3, -4].sum)
  end

  def test_sum_nil
    assert_equal(nil, [1, "foo", 3].sum)
  end

  def test_min_by_simple
    assert_equal(1, [1, 2, 3].min_by{|x| x + 1 })
  end
end
