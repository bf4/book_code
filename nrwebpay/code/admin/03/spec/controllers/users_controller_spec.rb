#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

RSpec.describe UsersController, :aggregate_failures do

  let(:logged_in_user) { create(:user) }
  let(:other_user) { create(:user) }

  describe "access to show and edit" do

    before(:example) do
      sign_in(logged_in_user)
    end

    it "allows a user to view their own page" do
      get :show, params: {id: logged_in_user}
      expect(response).to be_a_success
    end

    it "blocks a user from viewing another user's page" do
      get :show, params: {id: other_user}
      expect(response).to be_forbidden
      expect(controller.user_signed_in?).to be_falsy
    end

    context "logging in as an admin" do

      before(:example) { logged_in_user.admin! }

      it "allows an admin to view another user's page" do
        get :show, params: {id: other_user}
        expect(response).to be_a_success
      end

    end

  end

end
