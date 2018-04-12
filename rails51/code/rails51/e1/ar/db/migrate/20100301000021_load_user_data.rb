#---
# Excerpted from "Agile Web Development with Rails 5.1",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails51 for more book information.
#---
require 'active_record/fixtures'

class LoadUserData < ActiveRecord::Migration
  def self.up
    down

    directory = File.join(File.dirname(__FILE__), 'dev_data')
    Fixtures.create_fixtures(directory, "users")
  end

  def self.down
    User.delete_all
  end
end
