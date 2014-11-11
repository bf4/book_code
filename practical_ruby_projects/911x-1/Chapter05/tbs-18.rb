class NilClass
  def rep
    nil
  end
end

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

  def rep
    @data.collect do |row|
      row.collect do |item|
        item.rep
      end
    end
  end
end

class Map
  attr_reader :terrain, :units

  def initialize(key, layout)
    rows = layout.split("\n")
    rows.collect! {|row| row.gsub(/\s+/, '').split(//) }

    y = rows.size
    x = rows[0].size

    @terrain = Matrix.new(x, y)
    @units  = Matrix.new(x, y)

    rows.each_with_index do |row, y|
      row.each_with_index do |glyph, x|
        @terrain[x, y] = key[glyph]
      end
    end
  end

  def place(x, y, unit)
    @units[x, y] = unit
    unit.x = x
    unit.y = y
  end

  def move(old_x, old_y, new_x, new_y)
    raise LocationOccuppiedError.new(new_x, new_y) if @units[new_x, new_y]
    @units[new_x, new_y] = @units[old_x, old_y]
    @units[old_x, old_y] = nil
  end

  def all_positions
    @terrain.all_positions
  end

  def within?(distance, x1, y1, x2, y2)
    (x1 - x2).abs + (y1 - y2).abs <= distance
  end

  def near_positions(distance, x, y)
    all_positions.find_all{|x2, y2| within?(distance, x, y, x2, y2) }
  end

  def rep
    return [@terrain.rep, @units.rep]
  end
end

class LocationOccupiedError < Exception
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

class Unit
  attr_reader :player, :name, :health, :movement, :actions
  attr_accessor :x, :y
  def initialize(player, name)
    @player = player
    @name = name
    @health = 10
    @movement = 2
    @actions = []
  end

  def move(x, y)
    @player.game.map.move(@x, @y, x, y)
    @x = x
    @y = y
  end

  def hurt(damage)
    return if dead?
    @health -= damage
    die if dead?
  end

  def dead?
    return @health <= 0
  end

  def alive?
    return ! dead?
  end

  def die
    @player.game.message_all("#{name} died.")
  end

  def enemy?(other)
    (other != nil) && (player != other.player)
  end

  def friend?(other)
    (other != nil) && (player == other.player)
  end

  def done?; @done; end
  def done; @done = true; end
  def new_turn; @done = false; end
end

class FakeGame
  attr_accessor :map
end

class FakePlayer
  attr_accessor :game
end

class Human < Unit; end
class Soldier < Human; end
class Doctor < Human; end

class Dinosaur < Unit; end
class VRaptor < Dinosaur; end
class TRex < Dinosaur; end

forest = Terrain.new("Forest")
grass = Terrain.new("Grass")
mountains = Terrain.new("Mountains")
plains = Terrain.new("Plains")
water = Terrain.new("Water")

terrain_key = {
  "f" => forest,
  "g" => grass,
  "m" => mountains,
  "p" => plains,
  "w" => water,
}

map = Map.new terrain_key, <<-END
  gggggggggg
  gggggggwww
  ggggggwwff
  gggppppppp
  ggppggwfpf
  ggpgggwwff
END
