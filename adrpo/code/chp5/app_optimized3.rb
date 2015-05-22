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
  if col =~ /^\d+$/ # (1)
    col.to_i # (2)
  elsif match = /^(\d{4})-(\d{2})-(\d{2})$/.match(col) # (3)
    Date.new(match[1].to_i, match[2].to_i, match[3].to_i) # (4)
  else
    col # (5)
  end
end # (6)

def find_youngest(people)
  people.map! { |person| person[2] }.max
end

def dummy
end

def fake_parse_col
  dummy; dummy;
  dummy if rand < 2/3.0
end

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
end

# ...
data = generate_test_data
GC.disable
result = RubyProf.profile do
  people = parse_data(data)
  find_youngest(people)
  150000.times { fake_parse_col }
end

printer = RubyProf::CallTreePrinter.new(result)
printer.print(File.open("callgrind.out.app_optimized3", "w+"))
