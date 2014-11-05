#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'application'

# Make double-sure the RAILS_ENV is set to test, 
# so fixtures are loaded to the right database
silence_warnings { RAILS_ENV = "test" }

require 'test/unit'
require 'active_record/fixtures'
require 'action_controller/test_process'
require 'action_controller/integration'
require 'action_web_service/test_invoke'
require 'breakpoint'

Test::Unit::TestCase.fixture_path = RAILS_ROOT + "/test/fixtures/"

def create_fixtures(*table_names)
  Fixtures.create_fixtures(RAILS_ROOT + "/test/fixtures", table_names)
end
