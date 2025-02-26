# frozen_string_literal: true

module HandleResponse
  def render_success(status_code: 200, data: nil)
    render_response(status_code: status_code, data: data)
  end

  def render_error(status_code:, error_code:, error_msg:)
    render_response(status_code: status_code, error_hash: { code: error_code, message: error_msg })
  end

  def exception(result:, log:)
    Rails.logger.info(%(#{log} #{result.failure}))

    case result.failure
    when :invalid_request
      render_error(status_code: 400, error_code: :bad_request, error_msg: 'Bad request')
    when ::Error::UnauthorizedError
      render_error(status_code: 401, error_code: :unauthorized, error_msg: 'Unauthorized permission error')
    when ::Error::ForbiddenError
      render_error(status_code: 403, error_code: :forbidden, error_msg: 'Forbidden')
    when ::Commons::FailureConstant::RecordNotFound
      render_error(status_code: 404, error_code: :not_found, error_msg: 'Not Found')
    when ::Error::ParameterError
      render_error(status_code: 406, error_code: :invalid_request_parameters, error_msg: result.failure.message)
    when ::Commons::FailureConstant::InvalidParameter
      render_error(status_code: 405, error_code: :invalid_parameter, error_msg: result.failure.extras)
    when ::Commons::FailureConstant::GeocoderError
      render_error(status_code: 407, error_code: :invalid_location, error_msg: result.failure.extras)
    when ::Commons::FailureConstant::RecordInvalid
      render_error(status_code: 422, error_code: :unprocessable_entity, error_msg: result.failure.extras)
    else
      render_error(status_code: 500, error_code: :unknown_error, error_msg: 'Unknown Server Error')
    end
  end

  def serialize(data)
    {
      load: !params.key?(:search) || params[:search].blank? ? false : true,
      temperature: data&.dig('main', 'temp'),
      temperature_min: data&.dig('main', 'temp_min'),
      temperature_max: data&.dig('main', 'temp_max'),
      pressure: data&.dig('main', 'pressure'),
      humidity: data&.dig('main', 'humidity'),
      wind_speed: data&.dig('wind', 'speed'),
      description: data&.dig('weather', 0, 'description').try(:titleize),
      date: Time.zone.at(data&.dig('dt')).to_datetime.strftime('%Y-%m-%d'),
      time: Time.zone.at(data&.dig('dt')).to_datetime.strftime('%H:%M:%S'),
      city: data&.dig('name'),
      location: params[:search] || DEFAULT_LOCATION,
      icon: data&.dig('weather', 0, 'icon'),
      iconUrl: "https://openweathermap.org/img/wn/#{data&.dig('weather', 0, 'icon')}@2x.png",
      sunrise: Time.zone.at(data&.dig('sys', 'sunrise')).to_datetime.strftime('%H:%M:%S'),
      sunset: Time.zone.at(data&.dig('sys', 'sunset')).to_datetime.strftime('%H:%M:%S')
    }
  end

  private

  def render_response(status_code:, data: nil, error_hash: nil)
    resp_json = { status: status_code }.then do |j|
      j.merge!(data: data) if data
      j.merge!(error: error_hash) if error_hash
      j
    end

    render json: resp_json, status: status_code
  end
end
