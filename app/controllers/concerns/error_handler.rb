# frozen_string_literal: true

module ErrorHandler
  extend ActiveSupport::Concern
  included do
    rescue_from ActionController::InvalidAuthenticityToken do |e|
      render_exception(:unauthorized)
    end
  end

  private

  def render_exception(status)
    render_error_response({}, status) do |_, _status|
      render json: {
        status: I18n.t("errors.application.#{_status}.status"),
        title: I18n.t("errors.application.#{_status}.title"),
        detail: I18n.t("errors.application.#{_status}.detail"),
        errors: [I18n.t("errors.application.#{_status}.error_message")]
      }, status: _status
    end
  end
end
