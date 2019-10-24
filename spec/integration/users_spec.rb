require 'swagger_helper'

describe 'Twitter Lite API' do

  path '/users' do

    post 'Sign Up a user' do
      tags 'Userss'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            username: { type: :string },
            email: { type: :string },
            password: { type: :string }
          }
        },
        required: [ 'username', 'email', 'password' ]
      }

      response '201', 'user created' do
        let(:user) { { user: { username: "Kyalo", email: "kyalo@example.com", password: "Password12"}} }
        run_test!
      end
    end
  end
end