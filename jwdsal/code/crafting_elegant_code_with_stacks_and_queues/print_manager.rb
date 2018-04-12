#---
# Excerpted from "A Common-Sense Guide to Data Structures and Algorithms",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jwdsal for more book information.
#---
class PrintManager

  def initialize
    @queue = []
  end

  def queue_print_job(document)
    @queue.push(document)
  end

  def run
    while @queue.any?
      # the Ruby shift method removes and returns the
      # first element of an array:
      print(@queue.shift)
    end
  end

  private 

  def print(document)
    # Code to run the actual printer goes here. 
    # For demo purposes, we'll print to the terminal:
    puts document
  end

end

print_manager = PrintManager.new
print_manager.queue_print_job("First Document")
print_manager.queue_print_job("Second Document")
print_manager.queue_print_job("Third Document")
print_manager.run