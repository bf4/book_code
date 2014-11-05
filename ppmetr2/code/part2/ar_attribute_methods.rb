#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# Create a new database each time
File.delete 'dbfile' if File.exist? 'dbfile'

require 'active_record'
ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "dbfile" 
                                        
ActiveRecord::Base.connection.create_table :tasks do |t|
  t.string   :description
  t.boolean  :completed
end

class Task < ActiveRecord::Base; end

task = Task.new
task.description = 'Clean up garage'
task.completed = true
task.save

task.description    # => "Clean up garage"
task.completed?     # => true

my_query = "tasks.*, (description like '%garage%') as heavy_job"
task = Task.find(:first, :select => my_query)
task.heavy_job?  # => true

task = Task.find(:first, :conditions => {:completed => true})
task.description     # => "Clean up garage"

task = Task.find_by_description('Clean up garage')
task.id     # => 1

File.delete 'dbfile' if File.exist? 'dbfile'
