#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'ffi'

module User32
  extend FFI::Library
  ffi_lib        'user32'
  ffi_convention :stdcall

  typedef :pointer, :hwnd

  attach_function :GetForegroundWindow, [], :hwnd
  attach_function :GetWindowTextA, [:hwnd, :pointer, :int], :int
end

FFI::MemoryPointer.new(:char, 1000) do |buffer|
  hwnd = User32.GetForegroundWindow
  User32.GetWindowTextA hwnd, buffer, buffer.size
  p buffer.get_string(0)
  # >> "jruby - Cmd"
end
