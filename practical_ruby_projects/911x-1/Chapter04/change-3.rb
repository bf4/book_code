module Enumerable
  def min_by
    pairs = map{|x| [yield(x), x] }
    min_pair = pairs.min{|a, b| a.first <=> b.first }
    return min_pair.last
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
