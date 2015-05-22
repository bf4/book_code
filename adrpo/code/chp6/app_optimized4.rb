#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
require 'date'

# This generates CSV like
# 1, John McTest, 1980-07-01
# 2, Peter McGregor, 1985-12-23
# 3, Sylvia McIntosh, 1989-06-13
def generate_test_data
  50000.times.map do |i|
    name = ["John", "Peter", "Sylvia"][rand(3)] + " " +
           ["McTest", "McGregor", "McIntosh"][rand(3)]
    [i, name, Time.at(rand * Time.now.to_i).strftime("%Y-%m-%d") ].join(',')
  end.join("\n")
end

def parse_data(data)
  data.split("\n").map! { |row| parse_row(row) }
end

def parse_row(row)
  col1, col2, col3 = row.split(",")
  [
      col1.to_i,
      col2,
      Date.new(col3[0,4].to_i, col3[5,2].to_i, col3[8,2].to_i)
  ]
end

def find_youngest(people)
  people.map! { |person| person[2] }.max
end

data = generate_test_data
people = parse_data(data)
find_youngest(people)
