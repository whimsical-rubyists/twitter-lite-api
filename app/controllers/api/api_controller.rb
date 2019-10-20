# frozen_string_literal: true

module Api
  class ApiController < ActionController::API
    before_action :authenticate_request

    private

    def authenticate_request
      return true
    end
  end
end
