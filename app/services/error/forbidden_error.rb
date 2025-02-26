# frozen_string_literal: true

class Error::ForbiddenError < RuntimeError
  attr_reader :message, :extras

  def initialize(key, extras: {})
    @message = key
    @extras = extras
  end
end
