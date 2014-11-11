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
