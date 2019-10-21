# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }
  include SessionsHelpers
  include Response
  include ErrorHandler

  before_action :set_csrf_cookie

  private

  def set_csrf_cookie
    cookies["CSRF-TOKEN"] = form_authenticity_token
  end

  def not_authorized(msg)
    log_out
    render_response(msg, status = :unauthorized)
  end
end
