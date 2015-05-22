#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => "postgresql",
  :database => "company_data"
)

class Empsalary < ActiveRecord::Base
  attr_accessor :rank
end

time = Benchmark.realtime do
  salaries = Empsalary.all.order(:department_id, :salary)

  key, counter = nil, nil
  salaries.each do |s|
    if s.department_id != key
      key, counter = s.department_id, 0
    end
    counter += 1
    s.rank = counter
  end
end

puts "Group rank with ActiveRecord: %5.3fs" % time
