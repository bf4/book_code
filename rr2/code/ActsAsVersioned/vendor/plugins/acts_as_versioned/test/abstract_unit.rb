#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'rubygems'
require 'test/unit'
require 'active_record'
require 'active_record/fixtures'
require 'active_support/binding_of_caller'
require 'active_support/breakpoint'
require "#{File.dirname(__FILE__)}/../init"

config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
ActiveRecord::Base.establish_connection(config[ENV['DB'] || 'sqlite'])

load(File.dirname(__FILE__) + "/schema.rb")

# set up custom sequence on widget_versions for DBs that support sequences
if ENV['DB'] == 'postgresql'
  ActiveRecord::Base.connection.execute "DROP SEQUENCE widgets_seq;" rescue nil
  ActiveRecord::Base.connection.remove_column :widget_versions, :id
  ActiveRecord::Base.connection.execute "CREATE SEQUENCE widgets_seq START 101;"
  ActiveRecord::Base.connection.execute "ALTER TABLE widget_versions ADD COLUMN id INTEGER PRIMARY KEY DEFAULT nextval('widgets_seq');"
end

Test::Unit::TestCase.fixture_path = File.dirname(__FILE__) + "/fixtures/"
$LOAD_PATH.unshift(Test::Unit::TestCase.fixture_path)

class Test::Unit::TestCase #:nodoc:
  def create_fixtures(*table_names)
    if block_given?
      Fixtures.create_fixtures(Test::Unit::TestCase.fixture_path, table_names) { yield }
    else
      Fixtures.create_fixtures(Test::Unit::TestCase.fixture_path, table_names)
    end
  end

  # Turn off transactional fixtures if you're working with MyISAM tables in MySQL
  self.use_transactional_fixtures = true
  
  # Instantiated fixtures are slow, but give you @david where you otherwise would need people(:david)
  self.use_instantiated_fixtures  = false

  # Add more helper methods to be used by all tests here...
end