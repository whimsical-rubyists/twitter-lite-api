# frozen_string_literal: true

class Api::V1::SessionsController < Api::V1::ApiController
  skip_before_action :authenticate_request, only: %i[create]
  before_action :find_user, only: %i[create]

  def create
    if @user && @user.authenticate(sign_in_params[:password])
      if user.email_confirmed
        log_in(@user)
        remember(@user) if sign_in_params[:remember_me]
        response = {
          message: I18n.t("sessions.login.success"),
          username: @user.username,
          email: @user.email
        }
        render_response(response)
    else
      response = {
        error: I18n.t("sessions.login.failure"),
      }
      render_response(response, :unauthorized)
    end
  end

  def destroy
    log_out if logged_in?
    response = {
      message: I18n.t("sessions.logout.success"),
    }
    render_response(response)
  end

  private

  def sign_in_params
    params.require(:user).permit(:username, :password, :email, :remember_me)
  end

  def find_user
    @user = if sign_in_params[:username]
      User.find_by_username(sign_in_params[:username])
    elsif sign_in_params[:email]
      User.find_by_email(sign_in_params[:email])
    end
  end
end
