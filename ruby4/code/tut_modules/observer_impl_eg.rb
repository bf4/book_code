#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
require_relative 'observer_impl'

class TelescopeScheduler

  # other classes can register to get notifications
  # when the schedule changes
  include Observable   

  def initialize
    @observer_list = []  # folks with telescope time
  end
  def add_viewer(viewer)
    @observer_list << viewer
  end

  # ...
end
