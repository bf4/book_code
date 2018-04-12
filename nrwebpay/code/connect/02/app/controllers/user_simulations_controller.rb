#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class UserSimulationsController < ApplicationController

  def create
    @user_to_simulate = User.find(params[:id_to_simulate])
    authorize(@user_to_simulate, :simulate?)
    session[:admin_id] = current_user.id
    sign_in(:user, @user_to_simulate, bypass: true)
    redirect_to root_path
  end

  def destroy
    redirect_to(admin_users_path) && return if simulating_admin_user.nil?
    sign_in(:user, simulating_admin_user, bypass: true)
    session[:admin_id] = nil
    redirect_to admin_users_path
  end

end
