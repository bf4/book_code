#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'factories'
class ActiveSupport::TestCase

  # We don't use fixtures, so we comment this out:
  # fixtures :all
  def setup_designer
    @designer = Factory(:designer)
    3.times do
      creation = Factory(:creation, hours: 2, designer: @designer)
      @designer.projects << creation.project
    end
    @designer.save
  end
  
end
