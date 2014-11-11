require 'delegate'
require 'change'

module Enumerable
  def random
    self[rand(size)]
  end

  def bits_to_int
    (0...size).inject(0){|total, i| total + (self[i] * 2**i) }
  end
end

class Integer
  def bit_size
    raise "bit_size only valid for positive integers" if self < 0
    to_s(2).size
  end

  def uniform_crossover(other)
    max_bit_size = [self.bit_size, other.bit_size].max
    decision = rand(2**max_bit_size)
    crossover_when(other) {|i| decision[i] == 0 }
  end

  def crossover_when(other)
    max_bit_size = [self.bit_size, other.bit_size].max
    one, two = self, other
    result = (0...max_bit_size).inject(0) do |total, i|
      one, two = two, one if yield(i)
      total + (2**i * one.to_i[i])
    end
    return result
  end

  def point_crossover(other, n)
    possible_points = (0...bit_size).to_a
    points = []
    n.times { points.push(possible_points.delete_at(rand(possible_points.size))) }
    crossover_when(other){|i| points.include?(i) }
  end

  def one_point_crossover(other)
    point_crossover(other, 1)
  end

  def two_point_crossover(other)
    point_crossover(other, 2)
  end

  def mutate(prob)
    decision = rand(2**bit_size)
    mutated = (0...bit_size).map{|i| decision[i] == 0 ? self[i] : self[i] ^ 1}
    mutated.bits_to_int
  end
end

class BitIntAbuseError; end

class BitInt < DelegateClass(Integer)
  def self.sized(bits)
    subclass = Class.new(self)
    subclass.const_set(:BIT_SIZE, bits)
    return subclass
  end

  def initialize(value)
    raise BitIntAbuseError.new("Please subclass BitInt!") if self.class == BitInt
    raise BitIntAbuseError.new("BitInt values must be positive") if value < 0
    super(value)
  end

  def bit_size
    self.class::BIT_SIZE
  end

  def uniform_crossover(other); self.class.new(super(other)); end
  def one_point_crossover(other); self.class.new(super(other)); end
  def two_point_crossover(other); self.class.new(super(other)); end
  def point_crossover(other, n); self.class.new(super(other, n)); end
  def mutate(prob); self.class.new(super(prob)); end
end

class GeneticAlgorithm
  attr_reader :population

  def initialize(population_size, selection_size)
    @population = (0...population_size).map{|i| yield i }
    @selection_size = selection_size
    remember_best
  end

  def fittest(n=@selection_size)
    @population.sort_by{|member| member.fitness }[-n..-1]
  end

  def step
    survivors = fittest
    @population = (0...@population.size).map do |i|
      parent = survivors.random
      parent.reproduce(survivors)
    end
    remember_best
    return @best
  end

  def run(steps)
    steps.times { step }
    return @best
  end

  def remember_best
    current = fittest(1).first
    @best = current if @best.nil? || current.fitness > @best.fitness
  end
end

class DummyGenome
  def initialize(fitness)
    @fitness = fitness
  end

  def fitness
    @fitness
  end

  def reproduce(mates)
    return self
  end
end

class ChangeGenome < BitInt
  def self.given(prices, purchases, number_of_coins, bits_per_coin)
    bits = (number_of_coins - 1) * bits_per_coin
    subclass = self.sized(bits)
    subclass.const_set(:PRICES, prices)
    subclass.const_set(:PURCHASES, purchases)
    subclass.const_set(:NUMBER_OF_COINS, number_of_coins - 1)
    subclass.const_set(:BITS_PER_COIN, bits_per_coin)
    subclass.const_set(:CACHE, {})
    return subclass
  end

  def self.new_random
    bits = self::NUMBER_OF_COINS * self::BITS_PER_COIN
    return new(rand(2**bits))
  end

  def cache
    self.class::CACHE
  end

  def reproduce(mates)
    mate = mates.random
    return uniform_crossover(mate).mutate(0.25)
  end

  def fitness
    sim = ChangeSimulator.new(self.class::PRICES, *denoms)
    return 1.0/sim.run(self.class::PURCHASES)
  end

  def num
    self.class::NUMBER_OF_COINS
  end

  def bpc
    self.class::BITS_PER_COIN
  end

  def denoms
    coins = [1] + (0...num).map do |i|
      starting = i * bpc
      ending   = (i + 1) * bpc
      value = unpack(starting, ending) + 2
    end
    coins.sort
  end

  def unpack(starting, ending)
    num = ending - starting
    (0...num).inject(0) do |total, i|
      total + (self[starting + i] * (2**i))
    end
  end
end

number = 3
purchases = 400
bpc = 6

price_list = IO.readlines("prices.txt").map{|price| price.to_i }
prices = Prices.new(*price_list)

ChangeGenomeNumber = ChangeGenome.given(prices, purchases, number, bpc)
ga = GeneticAlgorithm.new(10, 7) { ChangeGenomeNumber.new_random }
puts ga.run(20).denoms.inspect
