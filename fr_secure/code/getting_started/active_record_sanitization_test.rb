#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require "rubygems"
require_gem "activerecord"

require 'test/unit'


ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.establish_connection({
  :adapter => "sqlite3", :dbfile => ":memory:"}
)



ActiveRecord::Schema.define(:version => 1) do
  create_table :users do |t|
    t.column :name, :string
    t.column :secret_question, :string
    t.column :secret_answer, :string
  end
end



class User < ActiveRecord::Base
end

class ActiveRecordSanitizationTest < Test::Unit::TestCase

  def test_first
   
    ben = User.new do|t|
      t.name = 'Ben'
      t.secret_question = 'What is your favorite food?'
    end
    ben.save
    
    User.find(:first, :conditions => ["name = ?", "Ben\047"])
    User.find(:first, :conditions => ["name = ?", "Ben\134\060\064\067"])
    
  end

end