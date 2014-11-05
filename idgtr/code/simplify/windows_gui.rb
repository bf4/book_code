#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
class String
  def snake_case
    gsub(/([a-z])([A-Z0-9])/, '\1_\2').downcase #(1)
  end
end


require 'Win32API'

module WindowsGui
  def self.def_api(function, parameters, return_value)              #(2)
    api = Win32API.new 'user32', function, parameters, return_value

    define_method(function.snake_case) do |*args|                   #(3)
      api.call *args                                                #(4)
    end
  end
end


module WindowsGui
  def_api 'FindWindow',    ['P', 'P'], 'L'
  def_api 'keybd_event',   ['I', 'I', 'L', 'L'], 'V'

  # rest of API definitions here...

  WM_GETTEXT = 0x000D
  WM_SYSCOMMAND = 0x0112

  # rest of constant definitions here...
end


module WindowsGui
  def_api 'FindWindow',      ['P', 'P'], 'L'
  def_api 'FindWindowEx',    ['L', 'L', 'P', 'P'], 'L'
  def_api 'PostMessage',     ['L', 'L', 'L', 'L'], 'L'
  def_api 'SendMessage',     ['L', 'L', 'L', 'P'], 'L'
  def_api 'keybd_event',     ['I', 'I', 'L', 'L'], 'V'
  def_api 'GetDlgItem',      ['L', 'L'], 'L'
  def_api 'GetWindowRect',   ['L', 'P'], 'I'
  def_api 'SetCursorPos',    ['L', 'L'], 'I'
  def_api 'mouse_event',     ['L', 'L', 'L', 'L', 'L'], 'V'
  def_api 'IsWindowVisible', ['L'], 'L'

  SC_CLOSE = 0xF060

  IDNO = 7

  MOUSEEVENTF_LEFTDOWN = 0x0002
  MOUSEEVENTF_LEFTUP = 0x0004

  KEYEVENTF_KEYDOWN = 0
  KEYEVENTF_KEYUP = 2
end


module WindowsGui
  VK_SHIFT   = 0x10
  VK_CONTROL = 0x11
  VK_BACK    = 0x08
end


class String
  def to_byte
    unpack('C')[0]
  end

  def to_keys
    unless size == 1                 #(5)
      raise "conversion is for single characters only"
    end

    ascii = self.to_byte             #(6)

    case self                        #(7)
    when '0'..'9'
      [ascii - '0'.to_byte + 0x30]
    when 'A'..'Z'
      [WindowsGui.const_get(:VK_SHIFT), ascii]
    when 'a'..'z'
      [ascii - 'a'.to_byte + 'A'.to_byte]
    when ' '
      [ascii]
    else
      raise "Can't convert unknown character #{self}"
    end
  end
end


module WindowsGui
  def keystroke(*keys)
    return if keys.empty?

    code = keys.first
    code = code.to_byte if code.is_a?(String)

    keybd_event code, 0, KEYEVENTF_KEYDOWN, 0
    sleep 0.05
    keystroke *keys[1..-1]
    sleep 0.05
    keybd_event code, 0, KEYEVENTF_KEYUP, 0
  end
end


module WindowsGui
  def type_in(message)
    message.scan(/./m) do |char|
      keystroke(*char.to_keys)
    end
  end
end


require 'timeout'

module WindowsGui
  class Window
    include WindowsGui #(8)

    attr_reader :handle

    def initialize(handle)
      @handle = handle
    end

    def close
      post_message @handle, WM_SYSCOMMAND, SC_CLOSE, 0
    end

    def wait_for_close #(9)
      timeout(5) do
        sleep 0.2 until 0 == is_window_visible(@handle)
      end
    end

    def text
      buffer = '\0' * 2048
      length = send_message @handle, WM_GETTEXT, buffer.length, buffer
      length == 0 ? '' : buffer[0..length - 1]
    end
  end
end


class WindowsGui::Window
  extend WindowsGui #(10)

  def self.top_level(title, seconds=3)
    @handle = timeout(seconds) do
      sleep 0.2 while (h = find_window nil, title) <= 0; h
    end

    Window.new @handle
  end
end


class WindowsGui::Window
  def child(id)
    result = case id
    when String
      by_title = find_window_ex @handle, 0, nil, id.gsub('_', '&') #(11)
      by_class = find_window_ex @handle, 0, id, nil
      by_title > 0 ? by_title : by_class
    when Fixnum
      get_dlg_item @handle, id
    else
      0
    end

    raise "Control '#{id}' not found" if result == 0
    Window.new result
  end
end


class WindowsGui::Window
  def click(id)
    h = child(id).handle

    rectangle = [0, 0, 0, 0].pack 'LLLL'
    get_window_rect h, rectangle
    left, top, right, bottom = rectangle.unpack 'LLLL'

    center = [(left + right) / 2, (top + bottom) / 2]
    set_cursor_pos *center

    mouse_event MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0
    mouse_event MOUSEEVENTF_LEFTUP, 0, 0, 0, 0
  end
end


module WindowsGui
  def dialog(title, seconds=3)
    d = begin
      w = Window.top_level(title, seconds)
      yield(w) ? w : nil #(12)
    rescue TimeoutError
    end

    d.wait_for_close if d
    return d
  end
end
