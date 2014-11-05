#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
require 'win32ole'

#   -4100 is the value for the Excel constant xl3DColumn.
ChartTypeVal = -4100;

excel = WIN32OLE.new("excel.application")

# Create and rotate the chart

excel['Visible'] = TRUE

excel.Workbooks.Add()
excel.Range("a1")['Value'] = 3
excel.Range("a2")['Value'] = 2
excel.Range("a3")['Value'] = 1

excel.Range("a1:a3").Select()

excelchart = excel.Charts.Add()
excelchart['Type'] = ChartTypeVal

30.step(180, 5) do |rot|
  excelchart.rotation = rot
  sleep(0.1)
end

excel.ActiveWorkbook.Close(0)
excel.Quit()

