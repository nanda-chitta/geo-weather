# frozen_string_literal: true

class WeatherManagement::Infrastructures::Repos::WeatherRepository
  include ::Dry::Monads::Result::Mixin
  include ::Dry::Monads::Maybe::Mixin
  include ::Dry::Monads::Try::Mixin

  def initialize
    @model = Weather
  end

  def get_transaction(&block)
    @model.transaction(&block)
  end
end
