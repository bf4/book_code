#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'ffi'


module POSIX
  extend FFI::Library
  ffi_lib 'c'

  attach_function :alarm,     [:uint], :uint
  attach_function :sigaction, [:int, :pointer, :pointer], :int

  # remaining definitions will go here...
end


module POSIX
  callback :handler_func, [:int], :void
  callback :action_func,  [:int, :pointer, :pointer], :void

  class SigActionU < FFI::Union
    layout :sa_handler, :handler_func,
           :sa_action,  :action_func
  end

  typedef  :int,        :sigset_t

  class SigAction < FFI::Struct
    layout :sa_action_u, SigActionU,
           :sa_flags,    :int,
           :sa_mask,     :int
  end
end


handler = FFI::Function.new(:void, [:int]) { |i| puts 'RING!' }

action = POSIX::SigAction.new
action[:sa_action_u][:sa_handler] = handler
action[:sa_flags] = 0
action[:sa_mask] = 0

out = POSIX::SigAction.new


SIGALRM = 14
POSIX.sigaction SIGALRM, action, out
POSIX.alarm 1

puts 'Going to bed'
sleep 2
puts 'Breakfast time'
