# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "CREATE /users" do

    let(:invalid_details) { { email: "mailwrong", username: "", password: "" } }
    let(:error_messages) {
      [
        "Password can't be blank",
        "Password can't be blank",
        "Password is invalid. A strong password should containt 6-10 characters, have a small case letter, an upper case letter and a digit.",
        "Username can't be blank",
        "Email is invalid. Use this format: user@example.com"
      ]
    }

    it "successfully creates a user" do
      post api_v1_users_path, params: { user: FactoryBot.attributes_for(:user) }
      expect(response).to have_http_status(201)

      expect(json_response["message"]).to eq("User created successfully")
    end

    it "returns error message when invalid details are provided" do
      post api_v1_users_path, params: { user: invalid_details }
      expect(response).to have_http_status(422)

      expect(json_response["errors"].length).to eq(5)
      expect(json_response["errors"]).to eq(error_messages)
    end

  end
end
