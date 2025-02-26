# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'routes for Api', type: :routing do
  it 'routes /api/v1/forecasts/search to the api/v1/weather_forecasts controller' do
    expect(get('/api/v1/forecasts/search')).to route_to({ controller: 'api/v1/weather_forecasts', action: 'search' })
  end
end
