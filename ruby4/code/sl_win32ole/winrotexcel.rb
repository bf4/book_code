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

#   Creates OLE object to Excel
#excel = WIN32OLE.new("excel.application.5")
excel = WIN32OLE.new("excel.application")

# Create and rotate the chart

excel.visible = TRUE;
excel.Workbooks.Add();
excel.Range("a1").value = 3;
excel.Range("a2").value = 2;
excel.Range("a3").value = 1;
excel.Range("a1:a3").Select();
excelchart = excel.Charts.Add();
excelchart.type = ChartTypeVal;

i = 30
i.step(180, 10) do |rot|
#    excelchart['Rotation'] = rot;
    excelchart.rotation=rot;
end
# Done, bye

excel.ActiveWorkbook.Close(0);
excel.Quit();

