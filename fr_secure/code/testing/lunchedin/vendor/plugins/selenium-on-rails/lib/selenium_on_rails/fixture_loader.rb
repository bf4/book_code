#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require 'test/unit'
require 'active_record'
require 'active_record/fixtures'

module SeleniumOnRails::FixtureLoader
  include SeleniumOnRails::Paths
  
  def available_fixtures
    fixtures = {}
    path = fixtures_path + '/'
    files = Dir["#{path}**/*.{yml,csv}"]
    files.each do |file|
      rel_path = file.sub(path, '')
      next if skip_file? rel_path
      fixture_set = File.dirname(rel_path)
      fixture_set = '' if fixture_set == '.'
      fixture = rel_path.sub /\.[^.]*$/, ''
      fixtures[fixture_set] ||= []
      fixtures[fixture_set] << fixture
    end
    
    fixtures
  end

  def load_fixtures fixtures_param
    available = nil
    fixtures = fixtures_param.split(/\s*,\s*/).collect do |f|
      fixture_set = File.dirname f
      fixture_set = '' if fixture_set == '.'
      fixture = File.basename f
      if fixture == 'all'
        available ||= available_fixtures
        available[fixture_set]
      else
        f
      end
    end
    fixtures.flatten!
    fixtures.reject! {|f| f.blank? }

    if fixtures.any?
      Fixtures.reset_cache # in case they've already been loaded and things have changed
      Fixtures.create_fixtures fixtures_path, fixtures
    end
    fixtures
  end

  def clear_tables tables
    table_names = tables.split /\s*,\s*/
    connection = ActiveRecord::Base.connection 
    table_names.each do |table|
      connection.execute "DELETE FROM #{table}" 
    end
    table_names
  end
  
end
