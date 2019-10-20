# frozen_string_literal: true

class Api::V1::SessionsController < Api::V1::ApiController
  skip_before_action :authenticate_request, only: %i[create]
  before_action :find_user, only: %i[create]

  def create
    if @user && @user.authenticate(sign_in_params[:password])
      log_in(@user)
      render json: {
        message: "User logged in successfully",
        username: @user.username,
        email: @user.email
      }, status: :ok
    else
      not_authorized("Email/Password do not match!!")
    end
  end

  def destroy
    log_out if logged_in?
    render json: { message: "Logged out successfully!" }, status: :ok
  end

  private

  def sign_in_params
    params.require(:user).permit(:username, :password)
  end

  def find_user
    @user = User.find_by_username(sign_in_params[:username])
  end
end
