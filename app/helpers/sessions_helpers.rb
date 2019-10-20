# frozen_string_literal: true


module SessionsHelpers
  def log_in(user)
    session[:user_id] = user.id
    session[:expires_at] = Time.current + 2.hours
  end

  # get current user from session or cookies if remember_me is chosen
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find(user_id)
    end
  end

  def logged_in?
    check_session_expiry
    !current_user.nil?
  end

  def check_session_expiry
    if session[:expires_at] < Time.current
      reset_session
    end
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user?(user)
    current_user == user
  end
end
