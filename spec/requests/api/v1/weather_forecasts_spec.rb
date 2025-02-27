require 'rails_helper'

RSpec.describe Api::V1::WeatherForecastsController, type: :request do
  describe "GET #search" do
    context 'when request with valid format' do
      context 'when request with valid location params' do
        let(:valid_format) { 'application/json' }
        let(:headers) { { 'Content-Type' => valid_format, 'Accept' => valid_format } }
        let(:location) { FactoryBot.build(:location, name: 'New York') }
        let(:data) {
          {
            'load' => true,
            'temperature' => 6.34,
            'temperature_min' => 4.98,
            'temperature_max' => 7.21,
            'pressure' => 1012,
            'humidity' => 70,
            'wind_speed' => 6.69,
            'description' => 'Clear Sky',
            'date' => '2025-02-26',
            'time' => '06:53:04',
            'type' => 'Clear',
            'city' => 'New York',
            'location' => 'New York',
            'icon' => '01d',
            'iconUrl' => 'https://openweathermap.org/img/wn/01d@2x.png',
            'sunrise' => '05:34:24',
            'sunset' => '16:43:42'
          }
        }

        it 'returns weather forecasts', vcr: { cassette_name: 'fetch weather forecast' } do
          get '/api/v1/forecasts/search', params: { search: location.name }, headers: headers

          body = JSON.parse(response.body)
          expect(body['data']).to eq(data)
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
      end
    end
  end
end
