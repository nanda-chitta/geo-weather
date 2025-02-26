# frozen_string_literal: true

class Error::ConflictError < RuntimeError
  attr_reader :message

  def initialize(key)
    @message = key
  end
end
