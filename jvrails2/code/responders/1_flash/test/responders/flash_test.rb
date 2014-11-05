#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
require "test_helper"
class FlashTest < ActionController::TestCase
  tests UsersController

  test "sets notice message on successful creation" do
    post :create, user: { name: "John Doe" }
    assert_equal "User was successfully created.", flash[:notice]
  end

  test "sets notice message on successful update" do
    user = User.create!(name: "John Doe")
    put :update, id: user.id, user: { name: "Another John Doe" }
    assert_equal "User was successfully updated.", flash[:notice]
  end

  test "sets notice message on successful destroy" do
    user = User.create!(name: "John Doe")
    delete :destroy, id: user.id
    assert_equal "User was successfully destroyed.", flash[:notice]
  end
end

class FlashTest < ActionController::TestCase
  test "sets alert messages from the controller scope" do
    begin
      I18n.backend.store_translations :en,
        flash: { users: { destroy: { alert: "Cannot destroy!" } } }

      user = User.create!(name: "Undestroyable")
      delete :destroy, id: user.id
      assert_equal "Cannot destroy!", flash[:alert]
    ensure
      I18n.reload!
    end
  end
end