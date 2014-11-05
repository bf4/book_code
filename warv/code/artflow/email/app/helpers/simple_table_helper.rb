#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
module SimpleTableHelper

  def simple_table_for(records, columns = {})
    presenter = SimpleTable.new(records, columns, self)
    if block_given?
      yield presenter
    else
      presenter
    end
  end

end
