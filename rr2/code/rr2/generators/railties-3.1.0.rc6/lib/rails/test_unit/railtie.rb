#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module Rails
  class TestUnitRailtie < Rails::Railtie
    config.app_generators do |c|
      c.test_framework :test_unit, :fixture => true,
                                   :fixture_replacement => nil

      c.integration_tool :test_unit
      c.performance_tool :test_unit
    end

    rake_tasks do
      load "rails/test_unit/testing.rake"
    end
  end
end
