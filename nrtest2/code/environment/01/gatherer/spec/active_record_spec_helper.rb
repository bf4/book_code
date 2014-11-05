#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require 'spec_helper'
require 'active_record'
require 'yaml'

connection_info = YAML.load_file("config/database.yml")["test"] 
ActiveRecord::Base.establish_connection(connection_info)

RSpec.configure do |config|
  config.around do |example|
    ActiveRecord::Base.transaction do 
      example.run
      raise ActiveRecord::Rollback
    end
  end
end
