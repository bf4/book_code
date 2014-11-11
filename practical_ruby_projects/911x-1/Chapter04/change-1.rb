class Prices
  def initialize(*data)
    @data = data
  end

  def get
    @data[rand(@data.size)]
  end
end
