# frozen_string_literal: true

class Api::V1::BaseController < ApplicationController
  before_action :ensure_json_request?
  include HandleResponse

  private

  def ensure_json_request?
    return true if request.format.json?

    render_error(status_code: 406, error_code: :bad_request, error_msg: 'Invalid request format')
  end
end
