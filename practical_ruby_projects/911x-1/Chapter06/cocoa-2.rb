require 'osx/cocoa'

app = OSX::NSApplication.sharedApplication

window = OSX::NSWindow.alloc.initWithContentRect_styleMask_backing_defer([0, 0, 500, 500], OSX::NSTitledWindowMask + OSX::NSClosableWindowMask, OSX::NSBackingStoreBuffered, true)
window.setTitleWithRepresentedFilename('Hello')
window.makeKeyAndOrderFront(nil)

OSX.NSApp.run