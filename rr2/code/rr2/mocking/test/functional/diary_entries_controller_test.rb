#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test_helper'

class DiaryEntriesControllerTest < ActionController::TestCase
  setup do
    @diary_entry = diary_entries(:one)
    SocialActivityStream.stubs(:notice)
  end

  test "should redirect to diary_entry page after create" do
    DiaryEntry.stubs(:new).returns(@diary_entry)
    @diary_entry.expects(:save).returns true
    post :create, :diary_entry => @diary_entry.attributes
    assert_redirected_to diary_entry_path(@diary_entry)
  end

  test "should redisplay the form on invalid create" do
    DiaryEntry.stubs(:new).returns(@diary_entry)
    @diary_entry.expects(:save).returns false
    post :create, :diary_entry => @diary_entry.attributes
    assert_template 'new'
  end
end
