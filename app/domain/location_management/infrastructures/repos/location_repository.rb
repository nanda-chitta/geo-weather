# frozen_string_literal: true

class LocationManagement::Infrastructures::Repos::LocationRepository
  include ::Dry::Monads::Result::Mixin
  include ::Dry::Monads::Maybe::Mixin
  include ::Dry::Monads::Try::Mixin

  def initialize
    @model = Location
  end

  def get_transaction(&block)
    @model.transaction(&block)
  end

  def update(location)
    Try(ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved, ActiveModel::UnknownAttributeError) do
      location.update!(updated_at: Time.zone.now)
      location.reload
    end.to_result.or do |failure|
      Rails.logger.error "[location][location_repository] #find_or_initialize_by #{failure}, location: #{location.inspect}"
      Failure(::Commons::FailureConstant::RecordInvalid.new(extras: failure.message))
    end
  end
end
