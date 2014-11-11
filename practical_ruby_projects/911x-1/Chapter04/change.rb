#!/usr/bin/env ruby

require 'pp'

module Enumerable
  @@cache = {}
  
  def permutations
    return @@cache[self].dup if @@cache[self]
    return [[]] if empty?
    others = rest.permutations
    return (@@cache[self.dup] = (others.map{|o| [first] + o} + others).uniq).dup
#    return (others.map{|o| [first] + o} + others).uniq
  end

  def sum
    inject(0) {|a, b| a + b } rescue nil
  end

  def rest
    return [] if empty?
    self[1..-1]
  end

  def permutations_of_size(n)
    perms = [[]]
    each do |item|
      add = []
      perms.each do |prev|
        newone = prev + [item]
        add.push newone if newone.size <= n
      end
      perms.push(*add)
      # Adding perms.uniq! here enables us to process large values of coins
      # that are all the same without combinatorial explosion.
      perms.uniq!
    end
    return perms.find_all{|p| p.size == n }
  end

  def min_by
    pairs = map{|x| [yield(x), x] }
    min_pair = pairs.min{|a, b| a.first <=> b.first }
    return min_pair.last
  end
end

class Customer
  def Customer.us(*coins)
    Customer.new([1, 5, 10, 25], *coins)
  end

  attr_reader :denoms, :coins

  def initialize(denoms, *coins)
    @coins  = coins.sort
    @denoms = denoms.sort

    coins.each{|denom| check_denom(denom) }

    @cm = ChangeMaker.new(*@denoms)
    check_optimal_start
  end

  def check_denom(denom)
    throw "Bad denomination #{denom}" unless denoms.include?(denom)
  end

  def check_optimal_start
    optimal = @cm.change(amount)
    if coins.size != optimal.size
      raise "Bad starting state #{coins.inspect} should be #{optimal.inspect}"
    end
  end

  def take!(coin)
    coins.push coin
    coins.sort!
    return self
  end

  def give!(coin)
    # Be careful not to call delete() because it removes all instances of an
    # object, and we support having more than one of each coin. Use delete_at
    # instead.
    raise "Don't have #{coin} coin to give" unless coins.include?(coin)
    coins.delete_at(coins.index(coin))
    return self
  end

  def ==(other)
    return false unless other.kind_of?(Customer)
    return false unless coins  == other.coins
    return false unless denoms == other.denoms
    return true
  end

  def to_s
    dollars = sprintf("$%.2f", amount.to_f/100)
    return "#{dollars} (#{coins.join(', ')})"
  end

  def amount
    coins.sum
  end

  def number
    coins.size
  end

  def pay!(bill)
    give = coins.permutations.min_by do |perm|
      amount = (perm.sum - bill) % 100
      change = @cm.change(amount)
      number - perm.size + change.size
    end

    amount = (give.sum - bill) % 100
    get = @cm.change(amount)

    # We should never hit this, but it's a good sanity check.
    # It caught several mistakes I made -- a pretty good investment.
    raise "Catastrophe" if give.nil? || get.nil?

    give.each {|d| give!(d) }
    get.each  {|d| take!(d) }
    return self
  end
end

class ChangeMaker
  def initialize(*coins)
    raise "ChangeMaker must have a coin of denomination 1" unless coins.include?(1)
    @coins = coins.sort
    @cache = {}
  end

  def change(amount)
    # Without doing dynamic programming things take too long
    return @cache[amount].dup if @cache[amount]
    return [] if amount == 0

    possible = @coins.find_all{|coin| coin <= amount }
    best = possible.min_by{|coin| change(amount - coin).size }
    
    # We should never hit this, but it's a good sanity check.
    # It caught several mistakes I made -- a pretty good investment.
    raise "Catastrophe" if best.nil?

    return (@cache[amount] = [best, *change(amount - best)].sort).dup
  end

  def inspect
    "<#ChangeMaker>"
  end
end

class Prices
  def initialize(*data)
    @data = data
  end

  def get
    @data[rand(@data.size)]
  end

  def each(count)
    count.times{ yield get }
  end
end

class ChangeSimulator
  def initialize(prices, *denoms)
    @prices   = prices
    @customer = Customer.new(denoms)
  end

  def run(length)
    sum = 0
    @prices.each(length) do |bill|
      @customer.pay!(bill)
      sum += @customer.number
    end
    return sum.to_f/length
  end
end

if $0 == __FILE__
  price_list = IO.readlines("prices.txt").map{|price| price.to_i }
  prices = Prices.new(*price_list)

#  sim = ChangeSimulator.new(prices, 1, 5, 10, 25)
#  puts sim.run(10000)
#  exit

#  possibilities = []
#  us_denoms = [5, 10, 25]
#  us_denoms.size.times do |i|
#    (2..99).each do |replacement|
#      denoms    = us_denoms.dup
#      denoms[i] = replacement
#
#      possibilities << [1, *denoms]
#    end
#  end
#  winner = possibilities.min_by do |denoms|
#    sim = ChangeSimulator.new(prices, *denoms)
#    sim.run(1000)
#  end
#  puts "The winner is: #{winner.sort.inspect}"
#  exit

#  winner = (2..99).min_by do |extra|
#    sim = ChangeSimulator.new(prices, 1, 5, 10, 25, extra)
#    sim.run(1000)
#  end
#  puts "The winner is: #{winner}"
#  exit

  number = 3
  choices = (2..99).to_a.permutations_of_size(number - 1).map{|p| p << 1 }

  t0 = Time.now.to_f
  counter = 0
  winner = choices.min_by do |denoms|
    counter += 1
    denoms.sort!
    puts "#{counter}/#{choices.size} #{denoms.inspect}"
    sim = ChangeSimulator.new(prices, *denoms)
    sim.run(400)
  end
  t1 = Time.now.to_f

  puts "The winner is: #{winner.sort.inspect}"
  puts t1 - t0
end
