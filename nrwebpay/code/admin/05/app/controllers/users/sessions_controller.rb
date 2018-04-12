#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class Users::SessionsController < Devise::SessionsController

  skip_before_action :set_paper_trail_whodunnit
  skip_after_action :warn_about_not_setting_whodunnit

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user&.authy_id.present?
      if @user&.valid_password?(params[:user][:password])
        session[:awaiting_authy_user_id] = @user.id
        Authy::API.request_sms(id: @user.authy_id)
        render :two_factor
      else
        render :new
      end
    else
      session[:awaiting_authy_user_id] = nil
      super
    end
  end

  def two_factor
  end

  def verify
    @user = User.find(session[:awaiting_authy_user_id])
    token = Authy::API.verify(id: @user.authy_id, token: params[:token])
    if token.ok?
      set_flash_message!(:notice, :signed_in)
      sign_in(User, @user)
      session[:awaiting_authy_user_id] = nil
      respond_with @user, location: after_sign_in_path_for(resource)
    else
      session[:awaiting_authy_user_id] = nil
      flash.now[:danger] = "Incorrect code, please try again"
      redirect_to users_sessions_two_factor_path
    end
  end

  def delete
    session[:awaiting_authy_user_id] = nil
    super
  end

end
