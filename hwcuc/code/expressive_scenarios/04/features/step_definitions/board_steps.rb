#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
Given /^a board like this:$/ do |table|
  @board = table.raw
end

When /^player x plays in row (\d+), column (\d+)$/ do |row, col|
  row, col = row.to_i, col.to_i
  @board[row][col] = 'x'
end

Then /^the board should look like this:$/ do |expected_board|
  expected_board.diff!(@board)
end
