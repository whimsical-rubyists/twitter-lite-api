# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }

  before_action :set_csrf_cookie
  include SessionsHelpers

  rescue_from ActionController::InvalidAuthenticityToken do |exception|
    log_out
    render { message : "Your session has been revoked" }
  end

  def set_csrf_cookie
    cookies["CSRF-TOKEN"] = form_authenticity_token
  end
end
