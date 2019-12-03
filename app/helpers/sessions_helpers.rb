# frozen_string_literal: true


module SessionsHelpers
  def log_in(user)
    session[:user_id] = user.id
    session[:expires_at] = Time.current + 2.hours
  end

  def log_in_user_from_cookies(user)
    if user && user.authenticated?(cookies[:remember_token])
      log_in(user)
      @current_user = user
    end
  end

  # get current user from session or cookies if remember_me is chosen
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find(user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find(user_id)
      log_in_user_from_cookies(user)
    end
  end

  def logged_in?
    unless session[:user_id].nil?
      check_session_expiry
    end
    !current_user.nil?
  end

  def check_session_expiry
    if session[:expires_at].nil? || session[:expires_at] < Time.current
      reset_session
    end
  end

  def log_out
    forget_user(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user?(user)
    current_user == user
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget_user(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
