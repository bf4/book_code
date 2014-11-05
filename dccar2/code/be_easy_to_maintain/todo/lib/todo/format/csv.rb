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
    class CSV
      def format(index,task)
        complete_flag = task.completed? ? "C" : "U"
        printf("%d,%s,%s,%s,%s\n",
               index,
               task.name,
               complete_flag,
               task.created_date,
               task.completed_date)
      end
    end
  end
end
