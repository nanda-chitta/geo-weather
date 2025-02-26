# frozen_string_literal: true

class Error::UnauthorizedError < RuntimeError
  attr_reader :message, :extras

  def initialize(key, extras: {})
    @message = key
    @extras = extras
  end
end
