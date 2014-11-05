#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
require 'win32ole'

class OOSpreadsheet
  def initialize
    mgr  = WIN32OLE.new('com.sun.star.ServiceManager')
    desktop = mgr.createInstance("com.sun.star.frame.Desktop")
    @doc = desktop.LoadComponentFromUrl("private:factory/scalc", "_blank", 0, [])
    @sheet = @doc.sheets[0]
  end

  def get_cell(row, col)
    @sheet.getCellByPosition(col, row, 0)
  end

  # tl: top_left, br: bottom_right
  def get_cell_range(tl_row, tl_col, br_row, br_col)   
    @sheet.getCellRangeByPosition(tl_row, tl_col, br_row, br_col, 0)
  end
end

spreadsheet = OOSpreadsheet.new
cell = spreadsheet.get_cell(1, 0)
cell.Value = 1234

cells = spreadsheet.get_cell_range(1, 2, 5, 3)
cols = cells.Columns.count
rows = cells.Rows.count

cols.times do |col_no|
  rows.times do |row_no|
    cell = cells.getCellByPosition(col_no, row_no)
    cell.Value = (col_no + 1)*(row_no+1)
  end
end
