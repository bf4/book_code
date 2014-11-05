#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require 'test_helper'

class ProjectPresenterTest < Minitest::Test

  def setup
    @project = Project.new(name: "Project Runway")
    @presenter = ProjectPresenter.new(@project)
  end

  def test_project_name_with_status_info
    @project.stubs(:on_schedule?).returns(true)
    expected = "<span class='on_schedule'>Project Runway</span>"
    assert_equal(expected, @presenter.name_with_status)
  end

  def test_project_name_with_status_info_behind_sechdule
    @project.stubs(:on_schedule?).returns(false)
    expected = "<span class='behind_schedule'>Project Runway</span>"
    assert_equal(expected, @presenter.name_with_status)
  end
end
