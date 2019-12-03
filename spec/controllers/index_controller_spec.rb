# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::IndexController, type: :controller do
  it "successfuly logs in user from remembered token" do
    user = create(:user, username: "testuser", password: "Password12")
    user.remember
    remember_token = user.remember_token


    my_cookies = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
    my_cookies.signed[:user_id] = user.id

    cookies["remember_token"] = remember_token
    cookies["user_id"] = my_cookies[:user_id]

    get :index
    expect(response).to have_http_status(200)
  end
end
