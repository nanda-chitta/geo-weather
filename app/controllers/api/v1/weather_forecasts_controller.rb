# frozen_string_literal: true

class Api::V1::WeatherForecastsController < Api::V1::BaseController
  include ::Dry::Monads::Result::Mixin

  def initialize
    @check_location = AppContainer['location_management.app_services.check_location']
    @weather_service = AppContainer['weather_management.app_services.weather_service']
  end

  def search
    result = @check_location.call(request.parameters)
    if result.success?
      location = result.value!
      @location_cache_key = "#{location.country}/#{location.zip_code}"
      @location_cache_exist = Rails.cache.exist?(@location_cache_key)
      query = { term: params[:search].presence || location.city }

      res = Rails.cache.fetch(@location_cache_key, expires_in: 30.minutes) do
        @weather_service.call(data: query)
      end

      if res.success?
        output = serialize(res.value!)
        Rails.cache.write(@location_cache_key, output, expires_in: 30.minutes)
        Rails.logger.info("Rails cache ::: #{Rails.cache.fetch(@location_cache_key)}")
        Rails.logger.info "[Api][v1][weather_forecasts_controller] #search success: #{output}"
        render_success(status_code: 200, data: output)
      else
        exception result: result, log: '[Api][v1][weather_forecasts_controller] #search error:'
      end
    else
      exception result: result, log: '[Api][v1][weather_forecasts_controller] #search error:'
    end
  end
end
