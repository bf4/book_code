#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'Win32API'
require 'timeout'

class String
  def snake_case
    gsub(/([a-z])([A-Z0-9])/, '\1_\2').downcase
  end

  def to_byte
    unpack('C')[0]
  end

  def to_keys
    unless size == 1
      raise "conversion is for single characters only"
    end

    code = self.to_byte

    case self
      when '0'..'9'
        [code - '0'.to_byte + 0x30]
      when 'A'..'Z'
        [WindowsGui.const_get(:VK_SHIFT), code]
      when 'a'..'z'
        [code - 'a'.to_byte + 'A'.to_byte]
      when ' '
        [code]
      when ','
        [WindowsGui.const_get(:VK_OEM_COMMA)]
      when '.'
        [WindowsGui.const_get(:VK_OEM_PERIOD)]
      when ':'
        [:VK_SHIFT, :VK_OEM_1].map {|s| WindowsGui.const_get s}
      when ';'
        [WindowsGui.const_get(:VK_OEM_1)]
      when "\\"
        [WindowsGui.const_get(:VK_OEM_102)]
      when "\n"
        [WindowsGui.const_get(:VK_RETURN)]
      else
        raise "Can't convert unknown character #{self}"
    end
  end
end

module WindowsGui
  def self.def_api(function, parameters, return_value, rename = nil)
    api = Win32API.new 'user32', function, parameters, return_value
    define_method(rename || function.snake_case) do |*args|
      api.call *args
    end
  end

  def self.load_symbols(header)
    File.open(header) do |f|
      f.grep(/#define\s+(ID\w+)\s+(\w+)/) do
        name = $1
        value = (0 == $2.to_i) ? $2.hex : $2.to_i #(1)
        WindowsGui.const_set name, value          #(2)
      end
    end
  end

  def_api 'FindWindow',          ['P', 'P'], 'L'
  def_api 'FindWindowEx',        ['L', 'L', 'P', 'P'], 'L'
  def_api 'SendMessage',         ['L', 'L', 'L', 'P'], 'L', :send_with_buffer
  def_api 'SendMessage',         ['L', 'L', 'L', 'L'], 'L'
  def_api 'PostMessage',         ['L', 'L', 'L', 'L'], 'L'
  def_api 'keybd_event',         ['I', 'I', 'L', 'L'], 'V'
  def_api 'GetDlgItem',          ['L', 'L'], 'L'
  def_api 'GetWindowRect',       ['L', 'P'], 'I'
  def_api 'SetCursorPos',        ['L', 'L'], 'I'
  def_api 'mouse_event',         ['L', 'L', 'L', 'L', 'L'], 'V'
  def_api 'IsWindow',            ['L'], 'L'
  def_api 'IsWindowVisible',     ['L'], 'L'
  def_api 'SetForegroundWindow', ['L'], 'L'

  WM_GETTEXT = 0x000D
  EM_GETSEL = 0x00B0
  EM_SETSEL = 0x00B1

  WM_COMMAND = 0x0111
  WM_SYSCOMMAND = 0x0112
  SC_CLOSE = 0xF060

  IDOK = 1
  IDCANCEL = 2
  IDYES = 6
  IDNO = 7

  MOUSEEVENTF_LEFTDOWN = 0x0002
  MOUSEEVENTF_LEFTUP = 0x0004
  MOUSEEVENTF_RIGHTDOWN = 0x0008
  MOUSEEVENTF_RIGHTUP = 0x0010

  KEYEVENTF_KEYDOWN = 0
  KEYEVENTF_KEYUP = 2

  VK_SHIFT = 0x10
  VK_CONTROL = 0x11
  VK_MENU = 0x12

  VK_BACK = 0x08
  VK_TAB = 0x09
  VK_RETURN = 0x0D
  VK_ESCAPE = 0x1B
  VK_OEM_1 = 0xBA
  VK_OEM_102 = 0xE2
  VK_OEM_PERIOD = 0xBE
  VK_HOME = 0x24
  VK_END = 0x23
  VK_OEM_COMMA = 0xBC
  VK_DELETE = 0x2E
  VK_F3 = 0x72

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

  def type_in(message)
    message.each_char do |char|
      keystroke(*char.to_keys)
    end
  end

  def wait_for_window(title, seconds = 5)
    timeout(seconds) do
      sleep 0.2 while
        (h = find_window nil, title) <= 0 ||
        window_text(h) != title
      h
    end
  end

  class Window
    include WindowsGui
    extend WindowsGui

    attr_reader :handle

    def initialize(handle)
      @handle = handle
    end

    def close
      post_message @handle, WM_SYSCOMMAND, SC_CLOSE, 0
    end

    def wait_for_close
      timeout(5) do
        sleep 0.2 until 0 == is_window_visible(@handle)
      end
    end

    def text(max_length = 2048)
      buffer = '\0' * max_length
      length = send_with_buffer @handle, WM_GETTEXT, buffer.length, buffer
      length == 0 ? '' : buffer[0..length - 1]
    end

    def child(id)
      result = case id
      when String
        by_title = find_window_ex @handle, 0, nil, id.gsub('_', '&') #(3)
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

    def click(id, which = :left, where = :center)
      h = child(id).handle

      rectangle = [0, 0, 0, 0].pack 'LLLL'
      get_window_rect h, rectangle
      left, top, right, bottom = rectangle.unpack 'LLLL'

      point = case where
      when Array
        where
      when :random
        [left + rand(right - left), top + rand(bottom - top)]
      else
        point = [(left + right) / 2, (top + bottom) / 2]
      end

      set_cursor_pos *point

      down, up = (:left == which) ?
        [MOUSEEVENTF_LEFTDOWN, MOUSEEVENTF_LEFTUP] :
        [MOUSEEVENTF_RIGHTDOWN, MOUSEEVENTF_RIGHTUP]

      mouse_event down, 0, 0, 0, 0
      mouse_event up, 0, 0, 0, 0

      return point
    end

    def self.top_level(title, seconds=10, wnd_class = nil)
      @handle = timeout(seconds) do
        loop do
          h = find_window wnd_class, title
          break h if h > 0
          sleep 0.3
        end
      end

      Window.new @handle
    end
  end

  DialogWndClass = '#32770'
  def dialog(title, seconds=5)
    close, dlg = begin
      sleep 0.25
      w = Window.top_level(title, seconds, DialogWndClass)
      Window.set_foreground_window w.handle
      sleep 0.25

      [yield(w), w]
    rescue TimeoutError
    end

    dlg.wait_for_close if dlg && close
    return dlg
  end
end
