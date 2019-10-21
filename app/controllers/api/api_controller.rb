# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    before_action :authenticate_request

    private

    def authenticate_request
      return if logged_in?
      render json: { "message": "You are not authenticated, kindly login first." }, status: :unauthorized
    end
  end
end
