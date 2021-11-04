# frozen_string_literal: true

class Api::V1::UserIntegersController < Api::V1::ApplicationController
  before_action :load_current_integer

  def show
    render_current_integer
  end

  def update
    if update_integer
      render_current_integer
    else
      render_errors
    end
  end

  def increment
    if increment_integer
      render_current_integer
    else
      render_errors
    end
  end

  private

  def render_current_integer
    render jsonapi: @current_integer
  end

  def render_errors
    render jsonapi_errors: @current_integer.errors, status: :unprocessable_entity
  end

  def update_integer
    @current_integer.change(action: :update, to: integer_params)
  end

  def increment_integer
    @current_integer.change(action: :increment)
  end

  def load_current_integer
    @current_integer = current_user.integer
  end

  def integer_params
    params.require(:value)
  end
end
