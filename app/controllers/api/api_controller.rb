# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    before_action :authenticate_request

    private

    def authenticate_request
      return if logged_in?
      render json: { "message": I18n.t("sessions.logout.failure") }, status: :unauthorized
    end
  end
end
