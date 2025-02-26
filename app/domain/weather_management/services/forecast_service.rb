# frozen_string_literal: true

class WeatherManagement::Services::ForecastService
  include Dry::Monads::Result::Mixin
  include Dry::Monads::Try::Mixin
  include Dry::Monads::Do.for(:forecast)

  def forecast(attr)
    response = connection.get('/data/2.5/weather', {
                                appid: WEATHER_API_KEY,
                                q: attr[:term],
                                units: 'metric'
                              })

    return Failure(:invalid_weather_response) unless response.success?

    Success(response.body)
  end

  private

  def connection
    Faraday.new(url: base_url) do |faraday|
      faraday.request :json # encode req bodies as JSON and automatically set the Content-Type header
      faraday.response :json # decode response bodies as JSON
    end
  end

  def base_url
    WEATHER_API_URL.to_s
  end
end
