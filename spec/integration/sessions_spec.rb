# frozen_string_literal: true

require "swagger_helper"

describe "Twitter Lite API" do

  before(:each) do
    create_user
  end

  path "/login" do

    post "Login a user" do
      tags "Sessions"
      consumes "application/json"
      produces "application/json"
      parameter name: :user, in: :body, schema: {
        type: :object,
        required: true,
        properties: {
          user: {
            type: :object,
            required: true,
            properties: {
              username: { type: :string },
              email: { type: :string, nullable: true },
              password: { type: :string }
            }
          }
        },
        required: ["user", "username", "password"]
      }

      response "200", "User logged in successfully" do

        let(:user) { { user: { username: "testuser", password: "Password12" } } }
        run_test!
      end

      response "401", "Login credentials do not match!!" do
        let(:user) { { user: { username: "", email: "kyalo@example.com", password: "pp" } } }
        run_test!
      end
    end
  end

  path "/logout" do

    delete "Logout a user" do
      tags "Sessions"
      produces "application/json"

      response "200", "Logged out successfully" do

        before do
          user = User.find_by_username("testuser")
          login(user)
        end

        run_test!
      end

      response "401", "You are not authenticated, kindly login first" do
        let(:user) { { user: { username: "", email: "kyalo@example.com", password: "pp" } } }
        run_test!
      end
    end
  end
end
