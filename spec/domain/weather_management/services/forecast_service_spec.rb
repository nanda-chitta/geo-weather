require 'rails_helper'

RSpec.describe WeatherManagement::Services::ForecastService do
  include Dry::Monads::Result::Mixin

  describe '.forecast' do
    let(:data) do
      {
        "coord" => {
          "lon" => -118.2437,
          "lat" => 34.0522
        },
        "weather" => [{
                        "id" => 800,
                        "main" => "Clear",
                        "description" => "clear sky",
                        "icon" => "01d"
                      }],
        "base" => "stations",
        "main" => {
          "temp" => 25.32,
          "feels_like" => 25.16,
          "temp_min" => 22.44,
          "temp_max" => 27.89,
          "pressure" => 1015,
          "humidity" => 48,
          "sea_level" => 1015,
          "grnd_level" => 996
        },
        "visibility" => 10000,
        "wind" => {
          "speed" => 2.98,
          "deg" => 240,
          "gust" => 1.88
        },
        "clouds" =>{ "all" => 0 },
        "dt" => 1740598541,
        "sys" => {
          "type" => 2,
          "id" => 2075946,
          "country" => "US",
          "sunrise" => 1740579910,
          "sunset" => 1740620807
        },
        "timezone" => -28800,
        "id" => 5368361,
        "name" => "Los Angeles",
        "cod" => 200
      }
    end

    context 'success' do
      let(:term) { { term: 'Los Angeles' } }

      it 'return weather forecast', vcr: { cassette_name: 'weather forecast service success' } do
        result = subject.forecast(term)
        expect(result.success?).to be_truthy
        expect(result.value!).to eq(data)
      end
    end
  end
end
