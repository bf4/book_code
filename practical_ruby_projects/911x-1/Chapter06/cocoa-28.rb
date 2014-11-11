require 'tbs'
require 'osx/cocoa'

module Enumerable
  def rest
    self[1..-1]
  end
end

class Location
  attr_accessor :col, :row, :terrain, :unit, :highlight, :on_click
  def initialize(col, row, drawer)
    @col, @row, @drawer = col, row, drawer
  end

  def draw
    @drawer.terrain(col, row, terrain) unless terrain.nil?
    @drawer.unit(col, row, unit) unless unit.nil?
    @drawer.highlight(col, row, highlight) unless highlight.nil?
  end

  def clear
    @on_click = nil
    @highlight = nil
  end
end

class Drawer
  def initialize(terrain, units, highlights)
    @terrain, @units, @highlights = terrain, units, highlights
  end

  def terrain(col, row, type); draw(col, row, @terrain[type]); end
  def unit(col, row, type); draw(col, row, @units[type]); end
  def highlight(col, row, type); draw(col, row, @highlights[type]); end

  def draw(col, row, tile)
    tile.draw(col, row) unless tile.nil?
  end
end

class ColorTile
  attr_reader :width, :height
  def initialize(width, height, r, g, b, a=1.0)
    @width, @height = width, height
    @color = OSX::NSColor.colorWithDeviceRed_green_blue_alpha(r, g, b, a)
  end

  def draw(col, row)
    x = col * @width
    y = row * @height
    area = OSX::NSRect.new(x, y, @width, @height)
    @color.set
    OSX::NSBezierPath.fillRect(area)
  end
end

class TBSView < OSX::NSView
  def initWithGrid(grid)
    init
    @grid = grid
    self
  end

  def drawRect(rect)
    @grid.all_positions.reverse.each do |x, y|
      @grid[x, y].draw
    end
  end
end

class ChoiceBar < OSX::NSMatrix
  MAX = 5

  def initAt(point)
    initWithFrame(OSX::NSRect.new(point.x, point.y, 1, 1))
    renewRows_columns(1, MAX)
    clear
    self
  end

  def clear
    @buttons = []
    setup
  end

  def setup
    MAX.times do |i|
      putCell_atRow_column(nil, 0, i)
    end

    @buttons.each_with_index do |button, i|
      putCell_atRow_column(button, 0, i)
    end

    if @buttons.size == 0
      setFrameSize(OSX::NSSize.new(1, 1))
    else
      size = @buttons.sort_by{|b| b.cellSize.width }.last.cellSize
      setFrameSize(OSX::NSSize.new(size.width * @buttons.size, size.height))
      setCellSize(size)
    end
    setNeedsDisplay(true)
    sv = superview
    sv.setNeedsDisplay(true) unless sv.nil?
  end

  def add(label, &callback)
    button = OSX::NSButtonCell.alloc.init
    button.setTitle(label)
    button.setBezelStyle(OSX::NSRoundedBezelStyle)
    button.setRepresentedObject(callback)
    button.setTarget(self)
    button.setAction(:clicked)
    @buttons.push(button)
  end

  def clicked(me)
    callback = selectedCell.representedObject
    callback.call unless callback.nil?
  end
end

class CocoaPlayer < BasePlayer
  DEFAULT_WIDTH = 500
  DEFAULT_HEIGHT = 500
  MESSAGE_HEIGHT = 30

  def cols; self.class.const_get(:COLS); end
  def rows; self.class.const_get(:ROWS); end
  def terrain_tiles; self.class.const_get(:TERRAIN); end
  def unit_tiles; self.class.const_get(:UNITS); end
  def highlight_tiles; self.class.const_get(:HIGHLIGHTS); end

  def initialize(name)
    super(name)

    @drawer = Drawer.new(terrain_tiles, unit_tiles, highlight_tiles)
    @grid = Matrix.new(cols, rows)
    @grid.all_positions.each do |col, row|
      @grid[col, row] = Location.new(col, row, @drawer)
    end

    some_tile = terrain_tiles.values.first
    window_width = cols * some_tile.width
    window_height = rows * some_tile.height

    app = OSX::NSApplication.sharedApplication
    app.setMainMenu(OSX::NSMenu.alloc.init)

    @view = TBSView.alloc.initWithGrid(@grid)
    @window = create_window(window_width, window_height, @view)
    
    messages_y = @view.frame.height - MESSAGE_HEIGHT
    @messages = create_messages(messages_y, @view.frame.width)
    @view.addSubview(@messages)

    @bar = ChoiceBar.alloc.initAt(OSX::NSPoint.new(0, 0))
    @view.addSubview(@bar)

    return self
  end

  def next_event(app)
    return app.nextEventMatchingMask_untilDate_inMode_dequeue(
      OSX::NSAnyEventMask,
      nil,
      OSX::NSDefaultRunLoopMode,
      true)
  end

  def handle_events
    app = OSX::NSApplication.sharedApplication
    while event = next_event(app)
      app.sendEvent(event)
    end
  end

  def create_window(width, height, view=nil)
    position = OSX::NSRect.new(0, 0, width, height)
    window = OSX::NSWindow.alloc.initWithContentRect_styleMask_backing_defer(
      position,
      OSX::NSTitledWindowMask + OSX::NSClosableWindowMask,
      OSX::NSBackingStoreBuffered,
      true)
    window.setTitleWithRepresentedFilename('Turn Based Strategy')
    window.makeKeyAndOrderFront(nil)
    window.setContentView(view)
    return window
  end

  def create_messages(y, width)
    position = OSX::NSRect.new(0, y, width, MESSAGE_HEIGHT)
    messages = OSX::NSTextView.alloc.initWithFrame(position)
    return messages
  end

  def create_button_bar(x, y, width)
    label = OSX::NSTextFieldCell.alloc.init
    label.setStringValue("Actions:")

    button = OSX::NSButtonCell.alloc.init
    button.setTitle("Test")
    button.setBezelStyle(OSX::NSRoundedBezelStyle)

    height = button.cellSize.height

    matrix = OSX::NSMatrix.alloc.initWithFrame([x, y, width, height])
    matrix.renewRows_columns(1, 2)
    matrix.putCell_atRow_column(label, 0, 0)
    matrix.putCell_atRow_column(button, 0, 1)
    matrix.setCellSize(button.cellSize)
    return matrix
  end

  def message(text)
    @messages.setString(text)
  end

  def draw(map)
    map.terrain.all_positions.each do |x, y|
      terrain = map.terrain[x, y]
      terrain_type = terrain.rep.first
      @grid[x, y].terrain = terrain_type
    end
    map.units.all_positions.each do |x, y|
      unit = map.units[x, y]
      unit_type = unit.nil? ? nil : unit.rep.first
      @grid[x, y].unit = unit_type
    end
    @view.setNeedsDisplay(true)
  end

  def do_choose(choices)
    choices.each do |choice|
      choice_rep = choice.rep
      choice_type = choice_rep.first
      ideal = "present_#{choice_type.downcase}_choice"
      if respond_to?(ideal)
        send(ideal, choice_rep, *choice_rep.rest)
      else
        present_choice(choice_rep)
      end
    end
    start_choice

    handle_events while true
  end
end

class DinoCocoaPlayer < CocoaPlayer
  COLS = 10
  ROWS = 6
  W = 50
  H = 50
  TERRAIN = {
    'Blank'  => ColorTile.new(W, H, 0.5, 0.5, 0.5),
    'Grass'  => ColorTile.new(W, H, 0.0, 1.0, 0.0),
    'Water'  => ColorTile.new(W, H, 0.0, 0.0, 1.0),
    'Forest' => ColorTile.new(W, H, 0.0, 0.8, 0.3),
    'Plains' => ColorTile.new(W, H, 0.8, 0.8, 0.8),
  }
  BLACK_BLOB = ColorTile.new(W, H, 0, 0, 0)
  UNITS = {
    'Captain' => BLACK_BLOB,
    'Doctor'  => BLACK_BLOB,
    'Soldier' => BLACK_BLOB,
    'VRaptor' => BLACK_BLOB,
  }
  HIGHLIGHTS = {
    'Unit'  => ColorTile.new(W, H, 0.8, 0.4, 0.0, 0.5),
    'Shoot' => ColorTile.new(W, H, 1.0, 0.0, 0.0, 0.5),
    'Move'  => ColorTile.new(W, H, 0.1, 0.1, 1.0, 0.5),
  }
end

class ApplicationGameDelegate < OSX::NSObject
  def initWithGame(game)
    init
    @game = game
    self
  end

  def applicationDidFinishLaunching(sender)
    @game.run
  end
end

human = DinoCocoaPlayer.new("Human")
game = run_dino(human)
delegate = ApplicationGameDelegate.alloc.initWithGame(game)
OSX::NSApplication.sharedApplication.setDelegate(delegate)
OSX.NSApp.run
