# frozen_string_literal: true

class WeatherManagement::AppServices::WeatherService
  include Dry::Monads::Result::Mixin
  include Dry::Monads::Try::Mixin
  include Dry::Monads::Do::All

  def initialize
    @forecast_service = AppContainer['weather_management.services.forecast_service']
  end

  def call(data:)
    result = yield @forecast_service.forecast(data)
    Success(result)
  end
end
