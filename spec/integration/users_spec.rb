# frozen_string_literal: true

require "swagger_helper"

describe "Twitter Lite API" do

  path "/users" do

    post "Sign Up a user" do
      tags "Users"
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
        required: ["user", "username", "email", "password"]
      }

      response "201", "User created successfully" do
        let(:user) { { user: { username: "Kyalo", email: "kyalo@example.com", password: "Password12" } } }
        run_test!
      end
    end
  end
end
