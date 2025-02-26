# frozen_string_literal: true

class LocationManagement::AppServices::Validators::LocationParam
  include Dry::Monads::Result::Mixin
  include Dry::Monads::Do.for(:validate)

  def validate(payload)
    valid_params = yield validate_params(payload)
    valid_location = valid_params[:location]

    Success(valid_location)
  end

  private

  def validate_params(payload)
    result = schema.call(payload)
    result.success? ? Success(result.to_h) : Failure(::Commons::FailureConstant::InvalidParameter.new(extras: result.errors.messages))
  end

  def schema
    ::Dry::Schema.Params do
      required(:location).schema do
        required(:name).filled(:str?).filled(max_size?: 190)
        optional(:latitude).maybe(:str?).maybe(max_size?: 50)
        optional(:longitude).maybe(:str?).maybe(max_size?: 50)
        optional(:address).maybe(:str?).maybe(max_size?: 190)
        optional(:city).maybe(:str?).maybe(max_size?: 190)
        optional(:state).maybe(:str?).maybe(max_size?: 190)
        optional(:zip_code).maybe(:str?).maybe(max_size?: 50)
        optional(:country).maybe(:str?, format?: COUNTRY_CODE_FORMAT).maybe(included_in?: ISO3166::Country.codes)
      end
    end
  end
end
