require 'tbs'
require 'osx/cocoa'

class TBSView < OSX::NSView
  def drawRect(rect)
    color = OSX::NSColor.colorWithDeviceRed_green_blue_alpha(0.0, 1.0, 0.0, 1.0)
    color.set
    OSX::NSBezierPath.fillRect(rect)
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

  def initialize(name)
    super(name)

    app = OSX::NSApplication.sharedApplication
    app.setMainMenu(OSX::NSMenu.alloc.init)

    @view = TBSView.alloc.init
    @window = create_window(@view)
    
    messages_y = @view.frame.height - MESSAGE_HEIGHT
    @messages = create_messages(messages_y, @view.frame.width)
    @view.addSubview(@messages)

    @bar = create_button_bar(0, 0, DEFAULT_WIDTH)
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

  def create_window(view=nil)
    window = OSX::NSWindow.alloc.initWithContentRect_styleMask_backing_defer(
      [0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT],
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
    puts map.inspect
  end

  def do_choose(choices)
    handle_events while true
  end
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

human = CocoaPlayer.new("Human")
game = run_dino(human)
delegate = ApplicationGameDelegate.alloc.initWithGame(game)
OSX::NSApplication.sharedApplication.setDelegate(delegate)
OSX.NSApp.run
