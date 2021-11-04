# frozen_string_literal: true

class Api::V1::ApplicationController < ApplicationController
  before_action :load_current_user
  before_action :authorize_current_user

  protected

  def current_user
    @current_user ||= load_current_user
  end

  private

  def authorize_current_user
    head :unauthorized if current_user.blank?
  end

  def load_current_user
    key = GetApiKey.call(bearer_token_string)
    User.find_by(api_key: key) if key.present?
  end

  def bearer_token_string
    request.headers[:Authorization] || ''
  end
end
