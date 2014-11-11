module Enumerable
  def random
    self[rand(size)]
  end
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