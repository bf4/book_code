require 'erb'

class Animation
  Template = ERB.new(<<-END)
<?xml version="1.0"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 20010904//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg width="<%= width %>" height="<%= height %>" xmlns="http://www.w3.org/2000/svg">
<% objects.each do |obj| %>
  <%= obj.render(frame) %>
<% end %>
</svg>
  END

  attr_reader :frame, :width, :height, :objects
    
  def initialize(width, height)
    @width     = width
    @height    = height
    @objects   = []
    @frame     = 0
    @step_callbacks = []
    @at_callbacks = Hash.new {|hash, key| hash[key] = [] }
  end

  def add(obj)
    @objects.push(obj)
  end

  def run(dir, frames)
    Dir.mkdir(dir) rescue nil
    digits = frames.to_s.size
      
    frames.times do |n|
      @frame = n
      file = frame_id(n, digits)
      filename = File.join(dir, file)

      run_callbacks
      render(filename)
    end
  end

  def frame_id(frame, digits)
    sprintf("%.#{digits}d", frame)
  end

  def at(frame, &callback)
    @at_callbacks[frame].push(callback)
  end

  def step(&callback)
    @step_callbacks.push(callback)
  end

  def run_callbacks
    @step_callbacks.each{|cb| cb.call }
    @at_callbacks[frame].each {|cb| cb.call }
  end

  def render(filename)
    File.open("#{filename}.svg", "w") do |file|
      file.write(Template.result(objbinding))
    end
    system("convert #{filename}.svg #{filename}.jpg")
    # Un-comment the next line to delete the intermediate SVG
    # File.unlink("#{filename}.svg")
  end

  def objbinding
    return binding
  end
end

class SVGObject
  def initialize(name, attrs={})
    @name     = name
    @attrs    = attrs
    @contents = []
  end

  def [](key)
    @attrs[key]
  end

  def []=(key, value)
    @attrs[key] = value
  end

  def add(obj)
    @contents.push(obj)
    return self
  end

  def render(frame)
    attrs = @attrs.map{|k, v| %Q{#{k}="#{v}"} }.join(' ')
    body  = @contents.map{|obj| obj.render(frame) }.join("\n")

    return %Q{<#{@name} #{attrs}>#{body}</#{@name}>}
  end

  def move_by(xd, yd)
    raise "Has no coordinates" unless @attrs[:x] && @attrs[:y]

    @attrs[:x] = @attrs[:x] + xd
    @attrs[:y] = @attrs[:y] + yd
    return self
  end

  def move_to(x, y)
    @attrs[:x] = x
    @attrs[:y] = y
    return self
  end
end

class Rect < SVGObject
  def initialize(x=0, y=0, width=100, height=100, attrs={})
    attrs[:x] = x
    attrs[:y] = y
    attrs[:width] = width
    attrs[:height] = height
    super(:rect, attrs)
  end
end

class Cube < SVGObject
  def initialize(x, y, z)
    super(:g)
    # 3D coordinates, _not_ SVG coordinates
    @x, @y, @z = x, y, z

    svgx = (x * 20) + (y * -20)
    svgy = (x * 10) + (y * 10) - (z * 20)
    self[:transform] = "translate(#{svgx}, #{svgy})"
    self[:fill]   = "#FEFEFE"
    self[:stroke] = "#000000"
    self[:'stroke-width'] = 1

    add(SVGObject.new(:polygon, :points => "0,10 20,20 40,10 20,0"))
    add(SVGObject.new(:polygon, :points => "0,10 0,35 20,45 20,20"))
    add(SVGObject.new(:polygon, :points => "20,20 20,45 40,35 40,10"))
  end
end

class GridDrawer
  protected

  def self.def_draw(*names)
    delta = {}
    delta = names.pop if names.last.kind_of?(Hash)
    delta.default = 0
    x, y, z = delta.values_at(:x, :y, :z)

    names.each do |name|
      self.class_eval("def #{name}(n=1); draw(n, #{x}, #{y}, #{z}); end")
    end
  end

  public

  def_draw :north, :n, :y => -1
  def_draw :south, :s, :y => +1
  def_draw :west,  :w, :x => -1
  def_draw :east,  :e, :x => +1
  def_draw :down,  :d, :z => -1
  def_draw :up,    :u, :z => +1

  def_draw :northwest, :nw, :y => -1, :x => -1
  def_draw :northeast, :ne, :y => -1, :x => +1
  def_draw :southwest, :sw, :y => +1, :x => -1
  def_draw :southeast, :se, :y => +1, :x => +1

  def initialize(object_class, container, x=0, y=0, z=0, &block)
    @object_class = object_class
    @container = container
    @pen = true
    @x   = x
    @y   = y
    @z   = z

    @block = block
  end

  def draw(rep=1, xd=0, yd=0, zd=0)
    rep.times do
      @x += xd
      @y += yd
      @z += zd
      @container.add(@object_class.new(@x, @y, @z)) if @pen
      wait
    end
  end
end
