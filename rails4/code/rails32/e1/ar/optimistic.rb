#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
$: << File.dirname(__FILE__)
require "connect"

require "rubygems"
require "active_record"

ActiveRecord::Schema.define do
  create_table :counters, :force => true do |t|
    t.integer :count
    t.integer :lock_version, :default => 0
  end
end


class Counter < ActiveRecord::Base
end

Counter.delete_all
Counter.create(:count => 0)

count1 = Counter.find(:first)
count2 = Counter.find(:first)

count1.count += 3 
count1.save
     
count2.count += 4 
count2.save
