# frozen_string_literal: true

# == Schema Information
#
# Table name: locations
#
#  id         :bigint           not null, primary key
#  address    :string
#  city       :string
#  country    :string
#  latitude   :string           default(""), not null
#  longitude  :string           default(""), not null
#  name       :string
#  state      :string
#  zip_code   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_locations_on_name  (name) UNIQUE
#
class Location < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: {
              scope: :city,
              case_sensitive: false,
              message: 'with city has already been taken.'
            },
            length: { maximum: 190 }
end
