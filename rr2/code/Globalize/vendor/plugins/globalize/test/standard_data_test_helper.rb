#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + '/../../../../config/environment')
require 'logger'
require 'test_help'

def inflate_schema(source, dest)
  File.open(dest, 'w') do |f|
    Zlib::GzipReader.open(source) do |gzip|
      gzip.each do |line|
        line.chomp!
        f.puts line
      end
    end
  end
end

plugin_path = RAILS_ROOT + "/vendor/plugins/globalize"

config_location = plugin_path + "/test/config/database.yml"

config = YAML::load(ERB.new(IO.read(config_location)).result)
ActiveRecord::Base.logger = Logger.new(plugin_path + "/test/log/test.log")
ActiveRecord::Base.establish_connection(config['test'])

mig_file = plugin_path + "/test/db/migrate/001_globalize_migration.rb"
gzipped_file = plugin_path + "/generators/globalize/templates/tiny_migration.rb.gz"
inflate_schema(gzipped_file, mig_file)

ActiveRecord::Migrator.migrate(plugin_path + "/test/db/migrate/", nil)
Test::Unit::TestCase.fixture_path = plugin_path + "/test/fixtures/"

$LOAD_PATH.unshift(Test::Unit::TestCase.fixture_path)

