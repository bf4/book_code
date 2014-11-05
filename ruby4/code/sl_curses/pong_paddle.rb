#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
# Draw the paddle for game of 'pong' that moves in response to up and down keys
require 'curses'
include Curses

class Paddle
  HEIGHT = 4
  PADDLE = " \n" + "|\n"*HEIGHT + " "
  def initialize
    @top = (Curses::lines - HEIGHT)/2
    draw
  end
  def up
    @top -= 1 if @top > 1
  end
  def down
    @top += 1 if (@top + HEIGHT + 1) < lines
  end
  def draw
    setpos(@top-1, 0)
    addstr(PADDLE)
    refresh
  end
end

init_screen
begin
  cbreak
  noecho
  stdscr.keypad(true)
  paddle = Paddle.new

  loop do
    case ch = getch
    when "Q", "q"            then   break
    when Key::UP, 'U', 'u'   then   paddle.up
    when Key::DOWN, 'D', 'd' then   paddle.down
    else 
      beep
    end
    paddle.draw
  end
ensure
  close_screen
end
