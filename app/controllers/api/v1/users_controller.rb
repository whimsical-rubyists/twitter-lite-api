# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::ApiController
      skip_before_action :authenticate_request, only: %i[create]

      def create
        @user = User.new(user_params)
        if @user.save
          UserMailer.account_confirmation(@user).deliver
          render json: { message: I18n.t("users.create.success") }, status: :created
        else
          render json: { errors: @user.errors.full_messages },
                        status: :unprocessable_entity
        end
      end

      def confirm_email
        user = User.find_by_confirm_token(params[:id])
        if user
          user.email_activate
          flash[:success] = "Welcome to Twitter-Lite. Your account has been activated"
        else
          flash[:error] = { message: I18n.t("users.create.error") }
          redirect_to root_url
        end
      end

      private

      def user_params
        params.require(:user).permit(:username, :email, :password)
      end
    end
  end
end
