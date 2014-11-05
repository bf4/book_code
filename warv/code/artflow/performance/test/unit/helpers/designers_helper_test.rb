#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
require 'test_helper'

class DesignersHelperTest < ActionView::TestCase

  def setup
    setup_designer
    @status = DesignerStatus.new(@designer, nil)
  end
  
  test 'designer_status_for helper returns a DesignerStatus instance' do
    assert_kind_of DesignerStatus, designer_status_for(@designer)
  end

  test 'designer_status_for helper yields a DesignerStatus instance' do
    yielded = nil
    designer_status_for(@designer) { |obj| yielded = obj }
    assert_kind_of DesignerStatus, yielded
  end
  
end

class DesignersHelperTest < ActionView::TestCase

  test 'calling to_s returns status markup' do
    status = designer_status_for(@designer)
    assert status.to_s.include?('<title>Status</title>')
  end
  
  test 'non-expanded status markup does not include active hours' do
    status = designer_status_for(@designer)
    assert !status.to_s.include?('Active Project Hours')
  end
  
  test 'expanded status markup includes active hours' do
    status = designer_status_for(@designer, expanded: true)
    assert status.to_s.include?('Active Project Hours')
  end
  
end
