#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class UsersController < ApplicationController

  before_action :load_user

  def show
  end

  def edit
  end

  def update
    @user.update(user_params)
    authorize(@user)
    render :show
  end

  private def load_user
    @user = User.find(params[:id])
    authorize(@user)
  end

  private def user_params
    params.require(:user).permit(:name)
  end

end
