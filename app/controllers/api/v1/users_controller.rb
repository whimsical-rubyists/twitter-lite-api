module Api
  module V1
    class UsersController < Api::V1::ApiController
      skip_before_action :authenticate_request, only: %i[create confirm_email]
      before_action :find_user_by_email, only: [:confirm_email]

      def create
        user = User.new(user_params)
        if user.save
          UserMailer.registration_confirmation(user).deliver_now
          render json: { message: I18n.t("users.create.success") }, status: :created
        else
          render json: { errors: user.errors.full_messages },
                        status: :unprocessable_entity
        end
      end

      def confirm_email
        if @user && !@user.email_confirmed && @user.validate_token(:confrim, params[:token])
          @user.confirm_email!
          log_in @user
          render json: { message: I18n.t("users.confirm.success")}, status: :ok
        else
          render json: { message: I18n.t("users.confirm.failure")}, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:username, :email, :password)
      end

      def find_user
        @user = User.find_by_email(params[:email])
      end
    end
  end
end
