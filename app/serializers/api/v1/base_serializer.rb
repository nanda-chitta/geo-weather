# frozen_string_literal: true

class Api::V1::BaseSerializer < ActiveModel::Serializer
  def created_at
    object.created_at&.in_time_zone&.iso8601
  end

  def updated_at
    object.updated_at&.in_time_zone&.iso8601
  end

  private

  def serializable
    ActiveModelSerializers::Adapter.create(self)
  end

  delegate :as_json, to: :serializable
end
