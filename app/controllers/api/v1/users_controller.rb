# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::ApiController
      skip_before_action :authenticate_request, only: %i[create]

      def create
        @user = User.new(user_params)
        if @user.save
          render json: { message: I18n.t("users.create.success") }, status: :created
        else
          render json: { errors: @user.errors.full_messages },
                        status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.fetch(:user, {}).permit(:username, :email, :password)
      end
    end
  end
end
