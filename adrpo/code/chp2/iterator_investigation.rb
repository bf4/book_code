#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
require 'csv'
GC.disable

methods = [:all?, :any?, :chunk, :collect, :collect_concat, :compact, :count, [:cycle, 1], :delete_if, :detect, :drop_while, :each_entry, :each, :each_index, :each_key, :each_pair, :each_value, :each_with_index, [:each_with_object, Object.new], :fill, :find, :find_all, :find_index, :flat_map, [:grep, 0], :group_by, :inject, :keep_if, :map, :none?, :one?, :reduce, :reject, :reverse, :reverse_each, :rotate, :select, :shuffle, :uniq]

# print only commonly used
methods = [:all?, :any?, :collect, [:cycle, 1], :delete_if, :detect, :each, :each_index, :each_key, :each_pair, :each_value, :each_with_index, [:each_with_object, Object.new], :fill, :find, :find_all, [:grep, 0], :inject, :map, :none?, :one?, :reduce, :reject, :reverse, :reverse_each, :select]

creators = [
  def new_array
    [0,1]
  end,
  def new_range
    (0..1)
  end,
  def new_hash
    {0 => 0, 1 => 1}
  end
]

data = []
CSV.open("iterator_investigation.csv", "w+") do |csv|
  csv << ["Iterator", "Array", "Range", "Hash"]

  methods.each do |method|

    args = nil
    if method.class == Array
      method, args = method
    end

    row = [method]

    creators.each do |creator|

      begin
        before = ObjectSpace.count_objects
        Array.new(10000).each do |i|
          if args
            send(creator).send(method, args) do |j|
            end
          else
            send(creator).send(method) do |j|
            end
          end
        end
        after = ObjectSpace.count_objects
        row << (after[:T_NODE] - before[:T_NODE]) / 10000
      rescue NoMethodError
        row << "&#8212;"
      end

    end

    csv << row
    data << row
  end
end

data.each do |row|
  puts "<row>"
    row.each do |col|
      puts "  <col>#{col}</col>"
    end
  puts "</row>"
end
