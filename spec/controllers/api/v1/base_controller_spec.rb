# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::BaseController, type: :controller do
  controller(described_class) do
    def index
      render json: { status: 200, message: 'Hello world' }
    end
  end

  context 'when valid format' do
    let(:valid_format) { 'application/json' }

    it 'returns 200 status' do
      request.headers['Content-Type'] = valid_format
      request.headers['Accept'] = valid_format
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  context 'when invalid format' do
    let(:invalid_format) { 'text/plain' }

    it 'returns 406 status' do
      request.headers['Content-Type'] = invalid_format
      request.headers['Accept'] = invalid_format
      get :index
      expect(response).to have_http_status(:not_acceptable)
    end
  end
end
