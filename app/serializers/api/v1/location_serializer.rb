# frozen_string_literal: true

class Api::V1::LocationSerializer < Api::V1::BaseSerializer
  attributes :id, :name, :address, :city, :state, :zip_code, :country, :latitude, :longitude
end
