# frozen_string_literal: true

class Error::NotModifiedError < RuntimeError
  attr_reader :message

  def initialize(key)
    @message = key
  end
end
