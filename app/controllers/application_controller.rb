# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }

  before_action :set_csrf_cookie
  include SessionsHelpers

  rescue_from ActionController::InvalidAuthenticityToken, with: :not_authorized


  def set_csrf_cookie
    cookies["CSRF-TOKEN"] = form_authenticity_token
  end

  private

  def not_authorized(msg = nil)
    log_out
    render json: { error: msg ? msg : "Not authorized" }, status: :unauthorized
  end
end
