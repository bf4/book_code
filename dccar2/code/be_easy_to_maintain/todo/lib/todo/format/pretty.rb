#---
# Excerpted from "Build Awesome Command-Line Applications in Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dccar2 for more book information.
#---
module Todo
  module Format
    class Pretty
      def format(index,task)
        printf("%2d - %s\n",index,task.name)
        printf("     %-10s %s\n","Created:",task.created_date)
        if task.completed?
          printf("     %-10s %s\n","Completed:",task.completed_date) 
        end
      end
    end
  end
end
