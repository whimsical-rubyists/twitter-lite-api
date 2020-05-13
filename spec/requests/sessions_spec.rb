# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Sessions", type: :request do
  describe "POST /login" do
    it "successfuly logs user in" do
      create_logged_in_user
      expect(cookies[:remember_token]).to be_falsey
      expect(response).to have_http_status(200)
      expect(json_response["message"]).to eq("User logged in successfully.")
      expect(json_response["email"]). to eq(User.first.email)
      expect(json_response["username"]). to eq(User.first.username)
    end

    it "successfuly logs user in and rememebers" do
      create_logged_remember_in_user
      expect(cookies[:remember_token]).to be_truthy
      expect(response).to have_http_status(200)
    end

    it "returns unauthorised if wrong password/username given" do
      post api_v1_login_path, params: { user: { username: "user", password: "Password" } }

      expect(response).to have_http_status(401)
      expect(json_response["error"]).to eq("Login credentials do not match!!")
    end

  end

  describe "DELETE /logout" do
    it "successfully logs out logged in user" do
      create_logged_in_user
      delete api_v1_logout_path
      expect(response).to have_http_status(200)
      expect(json_response["message"]).to eq("Logged out successfully!")
    end

    it "successfully logs out logged in user" do
      create_logged_remember_in_user
      expect(cookies[:remember_token]).to be_truthy
      delete api_v1_logout_path
      expect(cookies[:remember_token]).to be_empty
      expect(response).to have_http_status(200)
    end

    it "Gives appropriate message for unlogged in user" do
      delete api_v1_logout_path
      expect(response).to have_http_status(401)
      expect(json_response["message"]).to eq("You are not authenticated, kindly login first.")
    end
  end
end
