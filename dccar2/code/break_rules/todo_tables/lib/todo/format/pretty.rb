#---
# Excerpted from "Build Awesome Command-Line Applications in Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dccar2 for more book information.
#---
require 'rainbow'
module Todo
  module Format
    class Pretty
      def after; end

      # ...

      def format(index,task)
        color = :default
        if task.completed?
          color = :green 
        end

        puts sprintf("%2d - %s",index,task.name.bright).color(color)
        puts sprintf("     %-10s %s","Created:",task.created_date).color(color)
        if task.completed?
          puts sprintf("     %-10s %s","Completed:",task.completed_date).color(color)
        end
      end
    end
  end
end
