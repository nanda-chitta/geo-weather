require 'rails_helper'

RSpec.describe Api::V1::WeatherForecastsController, type: :controller do
  include ::Dry::Monads::Result::Mixin

  describe "GET #search" do
    context 'when invalid forecast params' do
      let(:data) do
        {
          'city' => 'Mumbai',
          'date' => '2025-02-26',
          'description' => 'Smoke',
          'humidity' => 33,
          'icon' => '50d',
          'iconUrl' => 'https://openweathermap.org/img/wn/50d@2x.png',
          'load' => false,
          'location' => '',
          'pressure' => 1012,
          'sunrise' => '19:30:16',
          'sunset' => '07:13:08',
          'temperature' => 31.99,
          'temperature_max' => 31.99,
          'temperature_min' => 30.94,
          'time' => '06:43:03',
          'wind_speed' => 2.57
        }
      end

      it 'return error response with empty location', vcr: { cassette_name: 'default location' } do
        get :search, params: { search: '' }, format: :json

        body = response.parsed_body
        expect(body['data']).to eq(data)
      end
    end

    context 'when weather forecast' do
      let(:location) { FactoryBot.build(:location) }
      let(:data) do
        {
          'load' => true,
          'temperature' => 14.12,
          'temperature_min' => 11.49,
          'temperature_max' => 16.95,
          'pressure' => 1013,
          'humidity' => 78,
          'wind_speed' => 3.6,
          'description' => 'Fog',
          'date' => '2025-02-26',
          'time' => '02:44:01',
          'city' => 'Los Angeles',
          'location' => 'Los Angeles',
          'icon' => '50n',
          'iconUrl' => 'https://openweathermap.org/img/wn/50n@2x.png',
          'sunrise' => '08:25:10',
          'sunset' => '19:46:47'
        }
      end

      it 'return success response with valid location', vcr: { cassette_name: 'fetch weather forecast' } do
        get :search, params: { search: location.name }, format: :json

        body = response.parsed_body
        expect(body['data']).to eq(data)
      end
    end

    context 'when weather forecast for invalid location' do
      let(:loc) { FactoryBot.build(:location, name: 'Hane Mission') }

      it 'return error response for location', vcr: { cassette_name: 'error weather forecast' } do
        get :search, params: { search: loc.name }, format: :json

        body = response.parsed_body
        expect(body['error']['message']).to eq('Unknown Server Error')
      end
    end

    context 'when invalid location for forecast' do
      it 'return error response for location', vcr: { cassette_name: 'invalid location for weather forecast' } do
        get :search, params: { search: 'Hane Mission' }, format: :json

        body = response.parsed_body
        expect(body['error']['message']).to eq('Unknown Server Error')
      end
    end
  end
end
