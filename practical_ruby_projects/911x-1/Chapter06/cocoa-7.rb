require 'tbs'
require 'osx/cocoa'

class CocoaPlayer < BasePlayer
  DEFAULT_WIDTH = 500
  DEFAULT_HEIGHT = 500

  def initialize(name)
    super(name)

    app = OSX::NSApplication.sharedApplication
    app.setMainMenu(OSX::NSMenu.alloc.init)

    @window = create_window
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

  def message(text)
    puts text
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
