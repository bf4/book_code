#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
require 'test_helper'
class DesignerTest < ActiveSupport::TestCase
  def setup
    setup_designer
    @status = DesignerStatus.new(@designer, nil)
  end

  test 'DesignerStatus instance calculates active projects' do
    assert_equal 3, @status.active_projects_count
  end
  
  test 'DesignerStatus instance calculates hours' do
    assert_equal [2, 2, 2], @status.hours_per_project.values
    assert_equal 6, @status.active_hours
  end
end
