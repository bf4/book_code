class GeneticAlgorithm
  attr_reader :population

  def initialize(population_size, selection_size)
    @population     = (0...population_size).map{|i| yield i }
    @selection_size = selection_size
  end
end
