class Matrix
  def initialize(cols, rows)
    @rows = rows
    @cols = cols
    @data = []
    rows.times do |y|
      @data[y] = Array.new(cols)
    end
  end

  def [](x, y)
    @data[y][x]
  end

  def []=(x, y, value)
    @data[y][x] = value
  end

  def all_positions
    (0...@rows).collect do |y|
      (0...@cols).collect do |x|
        [x, y]
      end
    end.inject([]) {|a, b| a.concat b}
  end
end

class Map
  attr_reader :terrain, :units
end

class Terrain
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def rep
    [@name]
  end
end

forest = Terrain.new("Forest")
grass = Terrain.new("Grass")
mountains = Terrain.new("Mountains")
plains = Terrain.new("Plains")
water = Terrain.new("Water")
