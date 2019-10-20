# frozen_string_literal: true


module SessionsHelpers
  def log_in(user)
    session[:user_id] = user.id
  end

  # get current user from session or cookies if remember_me is chosen
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find(user_id)
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user?(user)
    current_user == user
  end
end
