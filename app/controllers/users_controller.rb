# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { message: I18n.t("users.create.success") }, status: :created
    else
      render json: { errors: @user.errors.full_messages },
                    status: :unprocessable_entity
    end
  end

  def sign_in
    #
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def user_sign_in_params
  end
end
