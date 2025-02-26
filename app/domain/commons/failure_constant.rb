# frozen_string_literal: true

class Commons::FailureConstant < RuntimeError
  attr_accessor :extras
  attr_reader :key

  @extras = nil
  @key = nil

  class RecordNotFound < ::Commons::FailureConstant
    def initialize(extras: {})
      @key = :record_not_found
    end
  end

  class RecordInvalid < ::Commons::FailureConstant
    def initialize(extras: {})
      @key = :record_invalid
      @extras = extras
    end
  end

  class ServerError < ::Commons::FailureConstant
    def initialize
      @key = :server_error
    end
  end

  class TransitionForbiddenError < ::Commons::FailureConstant
    def initialize
      @key = :transition_forbidden_error
    end
  end

  class InvalidParameter < ::Commons::FailureConstant
    def initialize(extras: {})
      @key = :invalid_parameter
      @extras = extras
    end
  end

  class GeocoderError < ::Commons::FailureConstant
    def initialize(extras: {})
      @key = :invalid_location
      @extras = extras
    end
  end
end
