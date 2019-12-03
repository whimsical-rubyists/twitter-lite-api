# frozen_string_literal: true

def create_logged_in_user
  user = create(:user, username: "testuser", password: "Password12")
  post api_v1_login_path, params: { user: { username: user.username, password: "Password12" } }
end

def create_logged_remember_in_user
  user = create(:user, username: "testuser", password: "Password12")
  post api_v1_login_path, params: { user: { username: user.username, password: "Password12", remember_me: true } }
end

def login(user)
  post api_v1_login_path, params: { user: { username: user.username, password: "Password12" } }
end

def json_response
  JSON.parse(response.body)
end
