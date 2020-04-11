# frozen_string_literal: true

require "swagger_helper"

xdescribe "Twitter Lite API" do

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
              email: { type: :string },
              password: { type: :string }
            }
          }
        },
        required: ["user", "username", "password"]
      }

      response "200", "User logged in successfully" do
        User.create(username: "testuser", password: "Password12")
        let(:user) { { user: { username: "Kyalo", email: "kyalo@example.com", password: "Password12" } } }
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
        let(:user) { { user: { username: "Kyalo", email: "kyalo@example.com", password: "Password12" } } }
        run_test!
      end
      
      response "401", "Login credentials do not match!!" do
        let(:user) { { user: { username: "", email: "kyalo@example.com", password: "pp" } } }
        run_test!
      end
    end
  end
end
