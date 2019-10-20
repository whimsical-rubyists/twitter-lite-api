# frozen_string_literal: true

class Api::V1::IndexController < Api::V1::ApiController
  def index
    render json: "Welcome to Twitter Lite"
  end

  def indexv1
    render json: "Welcome to Twitter Lite V1"
  end
end
