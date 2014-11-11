module Enumerable
  def random
    self[rand(size)]
  end
end

class GeneticAlgorithm
  attr_reader :population

  def initialize(population_size, selection_size)
    @population     = (0...population_size).map{|i| yield i }
    @selection_size = selection_size
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
  end

  def run(steps)
    steps.times { step }
    return fittest(1).first
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
