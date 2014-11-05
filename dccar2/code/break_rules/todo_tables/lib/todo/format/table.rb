#---
# Excerpted from "Build Awesome Command-Line Applications in Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dccar2 for more book information.
#---
require 'terminal-table'
require 'time'

module Todo
  module Format
    class Table
      def initialize
        @table = Terminal::Table.new headings: %w(id name created completed) # (1)
        @table.align_column(0,:right) # (2)
      end

      def format(index,task)
        row = []
        row << index
        row << task.name
        row << as_date(task.created_date)      # (3)
		
        if task.completed?
          row << as_date(task.completed_date)
        else
          row << ''
        end
        @table << row
      end

      def after
        puts @table.to_s # (4)
      end
      private
      def as_date(string) # (5)
        Time.parse(string).strftime("%Y-%m-%d")
      end
    end
  end
end
