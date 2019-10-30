# frozen_string_literal: true

class Api::V1::SessionsController < Api::V1::ApiController
  skip_before_action :authenticate_request, only: %i[create]
  before_action :find_user, only: %i[create]

  def create
    if @user && @user.authenticate(sign_in_params[:password])
      log_in(@user)
      response = {
        message: "User logged in successfully",
        username: @user.username,
        email: @user.email
      }
      render_response(response)
    else
      response = {
        error: "Login credentials do not match!!"
      }
      render_response(response, :unauthorized)
    end
  end

  def destroy
    log_out if logged_in?
    response = {
      message: "Logged out successfully!"
    }
    render_response(response)
  end

  private

  def sign_in_params
    params.require(:user).permit(:username, :password, :email)
  end

  def find_user
    @user = if sign_in_params[:username]
      User.find_by_username(sign_in_params[:username])
    elsif sign_in_params[:email]
      User.find_by_email(sign_in_params[:email])
    end
  end
end
