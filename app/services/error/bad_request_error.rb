# frozen_string_literal: true

class Error::BadRequestError < RuntimeError
  attr_reader :message

  def initialize(key)
    @message = key
  end
end
