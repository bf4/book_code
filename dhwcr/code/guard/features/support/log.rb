#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
class Log
  attr_reader :contents
  def initialize(contents)
    @contents = contents
  end

  def append(priority, message)
    @contents << priority[0].upcase << ' ' << message
  end

  def parse
    @contents.split("\n").map do |line|
      initial, message = line.split(" ", 2)
      priorities = { 'I' => 'information', 'W' => 'warning' }
      { 'priority' => priorities[initial], 'message' => message }
    end
  end
end
