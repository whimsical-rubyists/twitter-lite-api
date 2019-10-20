# frozen_string_literal: true

class Api::V1::IndexController < ApplicationController
  def index
    render json: "Welcome to Twitter Lite"
  end

  def indexv1
    render json: "Welcome to Twitter Lite V1"
  end
end
