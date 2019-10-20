# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    include SessionsHelpers

    before_action :authenticate_request

    private

    def authenticate_request
      logged_in?
    end
  end
end
