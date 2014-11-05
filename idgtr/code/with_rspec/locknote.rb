#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
# Ruby supports the notion of "open classes;" that is, classes that can be
# defined in one place and modified later.  We'll use this technique to
# build up the LockNote class piece by piece for the examples.  In the real
# world, LockNote would be defined in one piece.


class Note
end


require 'timeout'
require 'Win32API' #(1)

def user32(name, param_types, return_value) #(2)
  Win32API.new 'user32', name, param_types, return_value
end

KEYEVENTF_KEYDOWN = 0
KEYEVENTF_KEYUP = 2

WM_SYSCOMMAND = 0x0112
SC_CLOSE = 0xF060

IDNO = 7

MOUSEEVENTF_LEFTDOWN = 0x0002
MOUSEEVENTF_LEFTUP = 0x0004

WM_GETTEXT = 0x000D


class Note
  def initialize
    find_window = user32 'FindWindow', ['P', 'P'], 'L'

    system 'start "" "C:/LockNote/LockNote.exe"'

    sleep 0.2 while (@main_window = find_window.call \
      nil, 'LockNote - Steganos LockNote') <= 0

    puts "The main window's handle is #{@main_window}."
  end

  def type_in(message)
    keybd_event = user32 'keybd_event', ['I', 'I', 'L', 'L'], 'V'

    message.upcase.each_byte do |b| #(3)
      keybd_event.call b, 0, KEYEVENTF_KEYDOWN, 0
      sleep 0.05
      keybd_event.call b, 0, KEYEVENTF_KEYUP, 0
      sleep 0.05
    end
  end

  def text
    find_window_ex = user32 'FindWindowEx', ['L', 'L', 'P', 'P'], 'L'

    send_message = user32 'SendMessage', ['L', 'L', 'L', 'P'], 'L'

    edit = find_window_ex.call @main_window, 0, 'ATL:00434310', nil

    buffer = '\0' * 2048 #(4)
    length = send_message.call edit, WM_GETTEXT, buffer.length, buffer

    return length == 0 ? '' : buffer[0..length - 1]
  end

  def exit!
    begin
      find_window = user32 'FindWindow', ['P', 'P'], 'L'

      post_message = user32 'PostMessage', ['L', 'L', 'L', 'L'], 'L'

      post_message.call @main_window, WM_SYSCOMMAND, SC_CLOSE, 0

      # You might need a slight delay here.
      sleep 0.5

      get_dlg_item = user32 'GetDlgItem', ['L', 'L'], 'L'

      dialog = timeout(3) do
        sleep 0.2 while (h = find_window.call \
          nil, 'Steganos LockNote') <= 0; h
      end

      button = get_dlg_item.call dialog, IDNO

      get_window_rect = user32 'GetWindowRect', ['L', 'P'], 'I'

      rectangle = [0, 0, 0, 0].pack 'LLLL'
      get_window_rect.call button, rectangle
      left, top, right, bottom = rectangle.unpack 'LLLL'

      puts "The No button is #{right - left} pixels wide."

      set_cursor_pos = user32 'SetCursorPos', ['L', 'L'], 'I'

      mouse_event = user32 'mouse_event', ['L', 'L', 'L', 'L', 'L'], 'V'

      center = [(left + right) / 2, (top + bottom) / 2]

      set_cursor_pos.call *center #(5)

      mouse_event.call MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0
      mouse_event.call MOUSEEVENTF_LEFTUP, 0, 0, 0, 0

      @prompted = true
    rescue TimeoutError
    end
  end

  def has_prompted?
    @prompted
  end
end
