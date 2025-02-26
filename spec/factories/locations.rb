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
FactoryBot.define do
  factory :location do
    name      { 'Los Angeles' }
    address   { Faker::Address.street_address }
    city      { Faker::Address.city }
    latitude  { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    state     { Faker::Address.state_abbr }
    zip_code  { Faker::Address.postcode }
    country   { Faker::Address.country_code }

    after(:build) { |loc| GeocoderStub.stub_with(loc) }
  end
end
