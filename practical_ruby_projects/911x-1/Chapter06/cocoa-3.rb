require 'tbs'
require 'osx/cocoa'

class CocoaPlayer < BasePlayer
  DEFAULT_WIDTH = 500
  DEFAULT_HEIGHT = 500
  
  def initialize(name)
    super(name)

    app = OSX::NSApplication.sharedApplication
    app.setMainMenu(OSX::NSMenu.alloc.init)

    @window = OSX::NSWindow.alloc.initWithContentRect_styleMask_backing_defer(
      [0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT],
      OSX::NSTitledWindowMask + OSX::NSClosableWindowMask,
      OSX::NSBackingStoreBuffered,
      true)
    @window.setTitleWithRepresentedFilename('Turn Based Strategy')
    @window.makeKeyAndOrderFront(nil)

    return self
  end
end
