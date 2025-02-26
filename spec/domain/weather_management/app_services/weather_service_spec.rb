require 'rails_helper'

RSpec.describe WeatherManagement::AppServices::WeatherService do
  include Dry::Monads::Result::Mixin

  let(:forecast_service) { double }

  before do
    AppContainer.stub('weather_management.services.forecast_service', forecast_service)
  end

  after do
    AppContainer.unstub('weather_management.services.forecast_service')
  end

  describe '#call(data:)' do
    let(:result) do
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
          "temp" => 25.83,
          "feels_like" => 25.59,
          "temp_min" => 20.77,
          "temp_max" => 28.26,
          "pressure" => 1015,
          "humidity" => 43,
          "sea_level" => 1015,
          "grnd_level" => 996
        },
        "visibility" => 10000,
        "wind" => {
          "speed" => 1.87,
          "deg" => 223,
          "gust" => 0.92
        },
        "clouds" =>{ "all" => 0 },
        "dt" => 1740595712,
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

    context 'successful' do
      let(:term) { { term: 'Los Angeles' }}

      it 'return weather forecast' do
        expect(forecast_service).to receive(:forecast).with(term).once.and_return(::Dry::Monads::Success(result))
        result = subject.call(data: term)
        expect(result.success?).to be_truthy
      end
    end

    context 'fail' do
      let(:term) { { term: '' }}

      it 'return failure' do
        expect(forecast_service).to receive(:forecast).with(term).once.and_return(::Dry::Monads::Failure(:invalid_weather_response))
        result = subject.call(data: term)
        expect(result.failure).to eq(:invalid_weather_response)
      end
    end
  end
end
