# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::ApiController
      skip_before_action :authenticate_request, only: %i[create confirm_email]
      before_action :find_user_by_email, only: [:confirm_email]

      def create
        user = User.new(user_params)
        # binding.pr
        user.confirmation_token
        if user.save
          # binding.pry
          UserMailer.registration_confirmation(user, user.confirm).deliver_later
          render json: { message: I18n.t("users.create.success") }, status: :created
        else
          render json: { errors: user.errors.full_messages },
                        status: :unprocessable_entity
        end
      end

      def confirm_email
        if @user && !@user.email_confirmed && @user.token_valid?(:confirm, params[:token])
          @user.email_activate!
          log_in @user
          render json: { message: I18n.t("users.confirm.success") }, status: :ok
        else
          render json: { message: I18n.t("users.confirm.failure") }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:username, :email, :password)
      end

      def find_user_by_email
        @user = User.find_by_email(params[:email])
      end
    end
  end
end
