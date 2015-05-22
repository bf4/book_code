#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
require 'date'
require 'rubygems'
require 'ruby-prof'

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
  row.split(",").map! { |col| parse_col(col) }
end

def parse_col(col)
  if col =~ /^\d+$/
    col.to_i
  elsif col =~ /^\d{4}-\d{2}-\d{2}$/
    Date.parse(col)
  else
    col
  end
end

def find_youngest(people)
  people.map! { |person| person[2] }.max
end

# ...
if ARGV[0] == "--test"

  ARGV.clear
  require 'minitest/autorun'

  class AppTest < MiniTest::Unit::TestCase

    def setup
      @parsed_data = parse_data(generate_test_data)
    end

    def test_parsing
      assert_equal @parsed_data.length, 50000
      assert @parsed_data.all? do |row|
        row.length == 3 && row[0].class == Fixnum && row[2].class == Date
      end
    end

    def test_find_youngest
      youngest = find_youngest(@parsed_data)
      assert @parsed_data.all? { |row| youngest >= row }
    end

  end

  exit(0)
elsif ARGV[0] == "--benchmark"

  require 'benchmark'

  data = generate_test_data
  result = Benchmark.realtime do
    people = parse_data(data)
    find_youngest(people)
  end
  puts "%5.3f" % result

  exit(0)
else
=begin
  data = generate_test_data
  GC.disable
  result = RubyProf.profile do
    people = parse_data(data)
    find_youngest(people)
  end
=end
end
# ...
data = generate_test_data
GC.disable
result = RubyProf.profile do
  people = parse_data(data)
  find_youngest(people)
end

printer = RubyProf::FlatPrinter.new(result)
printer.print(File.open("app_flat_profile.txt", "w+"), min_percent: 3)

RubyProf::GraphPrinter::PERCENTAGE_WIDTH = 7
RubyProf::GraphPrinter::TIME_WIDTH = 9
RubyProf::GraphPrinter::CALL_WIDTH = 15
printer = RubyProf::GraphPrinter.new(result)
if false
printer.print(File.open("app_graph_profile.txt", "w+"), min_percent: 3)

end
File.open("app_graph_profile.txt", "w+") { |f| printer.print(f, min_percent: 3); f.fsync }
profile = File.readlines("app_graph_profile.txt")
before_wait_col = RubyProf::GraphPrinter::PERCENTAGE_WIDTH*2 +
                  RubyProf::GraphPrinter::TIME_WIDTH*2
after_wait_col = before_wait_col + RubyProf::GraphPrinter::TIME_WIDTH
profile.map! do |line| 
  "#{line[0, before_wait_col]}#{line[after_wait_col, line.length]}"
end
File.open("app_graph_profile.txt", "w+") { |f| f.write(profile.join("")) }

printer = RubyProf::CallStackPrinter.new(result)
printer.print(File.open("app_call_stack_profile.html", "w+"))

printer = RubyProf::CallTreePrinter.new(result)
printer.print(File.open("callgrind.out.app", "w+"))
