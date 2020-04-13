# frozen_string_literal: true

class Api::V1::IndexController < Api::V1::ApiController
  def index
    render json: { message: I18n.t("info.welcome.index") }
  end

  def indexv1
    render json: { message: I18n.t("info.welcome.index_v1") }
  end
end
